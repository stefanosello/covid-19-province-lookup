<script type="text/javascript">
import Chart from 'chart.js';

export default {
  props: {
    data : {
      type: Object,
      default: () => {return {}}
    }
  },
  data() {
    return {
      chart: null
    }
  },
  mounted() {
    console.log("province mounted");
    Vue.nextTick(() => {
      const ctx = document.getElementById(`province-${this.data.province.code}-chart`).getContext('2d');
      this.chart = new Chart(ctx, {
        type: 'line',
        data: this.chartData,
        options: this.chartOptions
      });
    });
  },
  computed: {
    chartData() {
      return {
        labels: this.data.epidemic_data.map((epidemic) => {
          const date = new Date(epidemic.date)
          return date.toLocaleDateString();
        }),
        datasets: [this.getDataset()]
      }
    },
    chartOptions() {
      return {}
    }
  },
  methods: {
    getDataset() {
      return {
        label: this.data.province.label,
        data: this.data.epidemic_data.map((epidemic) => epidemic.total_cases)
      }
    }
  }
}
</script>

<template>
  <div id="province">
    <canvas :id="`province-${data.province.code}-chart`" width="400" height="400"></canvas>
  </div>
</template>

<style lang="scss">
  
</style>