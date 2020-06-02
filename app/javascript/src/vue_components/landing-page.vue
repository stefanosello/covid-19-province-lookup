<script type="text/javascript">
import 'tui-chart/dist/tui-chart.css'
import { lineChart } from '@toast-ui/vue-chart'
import { merge } from 'lodash'

export default {
  props: {
    nation: {
      type: Object,
      default: () => {return {}}
    },
    dates: {
      type: Array,
      default: () => []
    }
  },
  components: {
    'line-chart': lineChart
  },
  data() {
    return {
      datasets: [],
      isSidebarOpen: false,
      loading: true,
      nationData: this.nation
    }
  },
  mounted() {
    $.get({
      url: `http://ip-api.com/json/`,
      success: (ip_data) => {
        console.log(ip_data);
        $.get({
          url: `/api/v1/geo-data/ITA/${ip_data.regionName}`,
          success: (data) => {
            const regionIndex = this.nationData.regions.findIndex(region => region.label === data[0].regions[0].label);
            data[0].regions[0].provinces.forEach((province, index) => {
              this.addProvince(province);
              Vue.set(this.nationData.regions[regionIndex].provinces[index], "drawned", true);
            })
          }
        })
      }
    });
  },
  computed: {
    totalCasesChartData() {
      return {
        categories: this.dates.map((date) => (new Date(date)).toLocaleDateString()),
        series: this.datasets,
      }
    },
    totalCasesChartOptions() {
      return {
        chart: {
          width: 1108,
          height: 540,
          title: 'Covid-19: casi totali per provincia'
        },
        yAxis: {
          title: 'Numero di casi',
        },
        xAxis: {
          title: 'Giorno',
          pointOnColumn: true,
          dateFormat: 'MMM',
          tickInterval: 'auto'
        },
        series: {
          showDot: false,
          zoomable: true
        },
        plot: {
          bands: [
            {
              range: [
                (new Date(this.dates[0])).toLocaleDateString(),
                (new Date(this.dates[this.dates.length - 1])).toLocaleDateString()
              ],
              color: 'gray',
              opacity: 0.2
            }
          ]
        },
        chartExportMenu: {
          visible: false  // default is true.
        }
      }
    }
  },
  methods: {
    removeProvince(province) {
      this.datasets = this.datasets.filter(data => data.name != province.label)
    },
    addProvince(province) {
      this.loading = true;
      $.get({
        url: `/api/v1/epidemic-data/${province.initials}`,
        success: (data) => {
          this.datasets.push({
            name: data.province.label,
            data: data.total_cases,
          });
        },
        complete: () => {
          this.loading = false;
        }
      })
    }
  }
}
</script>

<template>
  <div class="container-fluid" landing-page-component>
    <div class="row">
      <div class="col-12 px-0 d-flex flex-column align-items-center">
        <navbar @open-sidebar="isSidebarOpen = true"></navbar>
        <div class="container chart-container">
          <line-chart v-if="datasets.length > 0 && !loading" ref="totalCasesChart" class="chart py-3 py-md-5" :options="totalCasesChartOptions" :data="totalCasesChartData"/>
        </div>
        <transition enter-active-class="animate__animated animate__fadeIn animate__fast" leave-active-class="animate__animated animate__fadeOut animate__fast">
          <div v-if="loading" class="position-absolute-center spinner-layer d-flex justify-content-center align-items-center">
            <div class="loadingio-spinner-pulse-rjn9w6gyclb">
              <div class="ldio-4twfh71h4gi">
                <div></div>
                <div></div>
                <div></div>
              </div>
            </div>
          </div>
        </transition>
      </div>
    </div>

    <transition enter-active-class="animate__animated animate__fadeIn animate__fast" leave-active-class="animate__animated animate__fadeOut animate__fast">
      <div class="sidebar-layer" v-if="isSidebarOpen" @click="isSidebarOpen = false"></div>
    </transition>

    <transition enter-active-class="animate__animated animate__slideInRight animate__fast" leave-active-class="animate__animated animate__slideOutRight animate__fast">
      <div class="sidebar-container" v-if="isSidebarOpen">
        <sidebar :nation="nationData" @remove-province="removeProvince" @add-province="addProvince" @close="isSidebarOpen = false"></sidebar>
      </div>
    </transition>
  </div>
</template>

<style lang="scss">
[landing-page-component] {

  .chart-container {
    min-height: calc(100vh - #{$header-height});
  }

  .chart {
    max-width: 100%;
    overflow-x: auto;
  }

  .sidebar-container,
  .sidebar-layer {
    position: fixed;
  }

  .sidebar-layer {
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
  }

  .spinner-layer,
  .sidebar-layer {
    background-color: rgba($gray-100, .7);
  }

  .sidebar-container {
    position: fixed;
    z-index: calc(#{$chart-zindex} + 2);
    top: 0;
    right: 0;
    width: 80vw;
    height: 100vh;

    @include media-breakpoint-up(md) {
      width: 50vw;
    }

    @include media-breakpoint-up(lg) {
      width: 35vw;
    }

    @include media-breakpoint-up(xl) {
      width: 25vw;
    }
  }

  /* spinner animation */

  @keyframes ldio-4twfh71h4gi-1 {
    0% { top: 36px; height: 128px }
    50% { top: 60px; height: 80px }
    100% { top: 60px; height: 80px }
  }
  @keyframes ldio-4twfh71h4gi-2 {
    0% { top: 41.99999999999999px; height: 116.00000000000001px }
    50% { top: 60px; height: 80px }
    100% { top: 60px; height: 80px }
  }
  @keyframes ldio-4twfh71h4gi-3 {
    0% { top: 48px; height: 104px }
    50% { top: 60px; height: 80px }
    100% { top: 60px; height: 80px }
  }
  .ldio-4twfh71h4gi div { position: absolute; width: 30px }.ldio-4twfh71h4gi div:nth-child(1) {
    left: 35px;
    background: #e15b64;
    animation: ldio-4twfh71h4gi-1 1s cubic-bezier(0,0.5,0.5,1) infinite;
    animation-delay: -0.2s
  }
  .ldio-4twfh71h4gi div:nth-child(2) {
    left: 85px;
    background: #f8b26a;
    animation: ldio-4twfh71h4gi-2 1s cubic-bezier(0,0.5,0.5,1) infinite;
    animation-delay: -0.1s
  }
  .ldio-4twfh71h4gi div:nth-child(3) {
    left: 135px;
    background: #abbd81;
    animation: ldio-4twfh71h4gi-3 1s cubic-bezier(0,0.5,0.5,1) infinite;
    animation-delay: undefineds
  }

  .loadingio-spinner-pulse-rjn9w6gyclb {
    width: 200px;
    height: 200px;
    display: inline-block;
    overflow: hidden;
  }

  .ldio-4twfh71h4gi {
    width: 100%;
    height: 100%;
    position: relative;
    transform: translateZ(0) scale(1);
    backface-visibility: hidden;
    transform-origin: 0 0; /* see note above */
  }
  .ldio-4twfh71h4gi div { box-sizing: content-box; }
  
  /* generated by https://loading.io/ */
}
</style>