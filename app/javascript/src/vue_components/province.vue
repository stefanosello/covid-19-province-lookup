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
  <div id="province" class="container">
    <canvas :id="`province-${data.province.code}-chart`" width="400" height="400"></canvas>
    <button class="btn btn-primary mx-auto my-4">OK, THX</button>
  </div>
</template>

<style lang="scss">
  canvas {
    max-height: 100vh;
  }
</style>