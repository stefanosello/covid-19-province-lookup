<script type="text/javascript">
const Highcharts = require('highcharts');  
require('highcharts/modules/exporting')(Highcharts); 

export default {
  props: {
    dates: {
      type: Array,
      default: () => []
    },
    datasets: {
      type: Array,
      default: () => []
    },
    chartId: {
      type: String,
      required: true
    },
    title: {
      type: String,
      required: true
    }
  },
  data() {
    return { }
  },
  mounted() {
    Vue.nextTick(() => {
      this.chart = new Highcharts.chart(this.chartId, {
        title: {text: this.title},
        chart: {
          scrollablePlotArea: {
            minWidth: 700
          }
        },
        xAxis: {
          type: 'datetime'
        },
        series: this.datasets.map(data => {
          const start = new Date(this.dates[0])
          const end = new Date(this.dates[this.dates.length-1])
          data.pointStart = start.valueOf();
          data.pointInterval = 24*3600*1000;
          return data;
        })
      });
    })
  },
  computed: { },
  methods: { }
}
</script>

<template>
  <div :id="chartId" chart-component>
  </div>
</template>

<style lang="scss">
[chart-component] { /* nothing to style */ }
</style>