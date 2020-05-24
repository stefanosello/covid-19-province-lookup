<script type="text/javascript">
import 'tui-chart/dist/tui-chart.css'
import { lineChart } from '@toast-ui/vue-chart'

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
      isSidebarOpen: false
    }
  },
  mounted() { },
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
        }
      }
    }
  },
  methods: {
    removeProvince(province) {
      this.datasets = this.datasets.filter(data => data.name != province.label)
    },
    addProvince(province) {
      $.get({
        url: `/api/v1/epidemic-data/${province.initials}`,
        success: (data) => {
          this.datasets.push({
            name: data.province.label,
            data: data.total_cases,
          });
        }
      })
    }
  }
}
</script>

<template>
  <div id="province" class="container-fluid" landing-page-component>
    <div class="row">
      <div class="col-12 col-lg-8 col-xl-9 px-0 d-flex flex-column align-items-center">
        <navbar @open-sidebar="isSidebarOpen = true"></navbar>
        <div class="container">
          <line-chart v-if="datasets.length > 0" ref="totalCasesChart" class="chart py-5" :options="totalCasesChartOptions" :data="totalCasesChartData"/>
          <div class="py-5" v-else>
            <div class="display-1 mb-5">Ciao :)</div>
            <div> Sono Stefano, uno studente di informatica e programmatore web che in quarantena aveva voglia di sviluppare qualcosa.
              Dal momento che sono un fissato coi dati, e che i canali ufficiali mi fornivano i dati sull'andamento dei contagi a livello provinciale, ma non me li 
              facevano visualizzare con dei grafici, ho deciso di mettere qui la possibilità di farlo, mettendo anche a confronto i grafici di varie province.
              Dalla spalla di destra è possibile selezionare le province, raggruppate per regioni, di cui si vogliono visualizzare i dati. Buona consultazione ;)
            </div>
          </div>
        </div>
      </div>
      <div class="d-none d-lg-block col-lg-4 col-xl-3 px-0">
        <sidebar :nation="nation" @remove-province="removeProvince" @add-province="addProvince"></sidebar>
      </div>
    </div>

    <transition enter-active-class="animate__animated animate__fadeIn" leave-active-class="animate__animated animate__fadeOut">
      <div class="d-lg-none sidebar-layer" v-if="isSidebarOpen"></div>
    </transition>

    <transition enter-active-class="animate__animated animate__slideInRight" leave-active-class="animate__animated animate__slideOutRight">
      <div class="d-lg-none sidebar-container" v-if="isSidebarOpen">
        <sidebar :nation="nation" @remove-province="removeProvince" @add-province="addProvince" @close="isSidebarOpen = false"></sidebar>
      </div>
    </transition>
  </div>
</template>

<style lang="scss">
[landing-page-component] {
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
    background-color: rgba($gray-100, .7);
  }

  .sidebar-container {
    position: fixed;
    z-index: calc(#{$chart-zindex} + 2);
    top: 0;
    right: 0;
    width: 80vw;
    height: 100vh;
  }
}
</style>