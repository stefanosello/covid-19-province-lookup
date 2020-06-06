<script type="text/javascript">
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
  data() {
    return {
      totalCasesDatasets: [],
      deltaCasesDatasets: [],
      isSidebarOpen: false,
      loading: true,
      nationData: this.nation
    }
  },
  mounted() {
    const callback = (geolocation) => {
      const lat = geolocation.coords.latitude || geolocation.lat;
      const lng = geolocation.coords.longitude || geolocation.lon;
      $.get({
        url: `/api/v1/geo-data/province-by-coords?latitude=${lat}&longitude=${lng}`,
        success: (data) => {
          Vue.set(this.nationData["regions"][data.region_code]["provinces"][data.code], "drawned", true);
          this.addProvince(data);
        }
      })
    }
    if (navigator.geolocation) {
      // if access to geolocation browser api is granted, use it to get coords
      navigator.geolocation.getCurrentPosition(callback);
    } else {
      // else use ip to geolocation api
      $.get({
        url: `http://ip-api.com/json/`,
        success: callback
      });
    }
  },
  computed: { },
  methods: {
    removeProvince(province) {
      this.loading = true;
      this.totalCasesDatasets = this.totalCasesDatasets.filter(data => data.name != province.label);
      this.deltaCasesDatasets = this.deltaCasesDatasets.filter(data => data.name != province.label);
      Vue.nextTick(() => {
        this.loading = false;
      })
    },
    addProvince(province) {
      this.loading = true;
      $.get({
        url: `/api/v1/epidemic-data/${province.initials}`,
        success: (data) => {
          this.totalCasesDatasets.push({
            name: data.province.label,
            data: data.total_cases,
          });
          this.deltaCasesDatasets.push({
            name: data.province.label,
            data: data.delta_cases
          })
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
        <div class="p-3 py-md-5 px-md-0 w-100 mh-100vh-header">
          <div class="container chart-container p-4 p-md-5 mb-3 mb-md-5">
            <chart
              v-if="totalCasesDatasets.length > 0 && !loading"
              chartId="totalsPerProvinceChart"
              :datasets="totalCasesDatasets"
              :dates="dates"
              title="Casi totali per provincia"
            ></chart>
          </div>
          <div class="container chart-container p-4 p-md-5">
            <chart
              v-if="deltaCasesDatasets.length > 0 && !loading"
              chartId="deltaPerProvinceChart"
              :datasets="deltaCasesDatasets"
              :dates="dates"
              title="Variazione giornaliera casi per provincia"
            ></chart>
          </div>
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

    <div class="row footer d-flex justify-content-center align-items-center text-white">Made with ♥ by <a class="ml-1" target="_blank" href="http://www.stefanosello.it">Mr5he11</a>.</div>

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

  $chart-background-color: whitesmoke;

  .chart-container {
    border-radius: 2rem;
    background-color: $chart-background-color;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.1), 0 6px 20px 0 rgba(0, 0, 0, 0.1);

    .highcharts-background {
      fill: $chart-background-color !important;
    }
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

  .footer {
    background-color: lighten($gray-700, 25);
    height: 5rem;
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