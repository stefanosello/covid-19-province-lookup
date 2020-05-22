<script type="text/javascript">
import Chart from 'chart.js';

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
      chart: null,
      datasets: []
    }
  },
  mounted() {
    this.initChart();
  },
  computed: {
    chartData() {
      return {
        labels: this.dates.map((date) => (new Date(date)).toLocaleDateString()),
        datasets: this.datasets,
      }
    },
    chartOptions() {
      return {
        animation: {
          duration: 0
        }
      }
    }
  },
  methods: {
    isProvinceDrawned(province) {
      return this.datasets.filter(data => data.initials === province).length > 0;
    },
    toggleProvince(province) {
      this.chart.destroy();
      if (this.isProvinceDrawned(province)) {
        this.datasets = this.datasets.filter(data => data.initials != province);
        this.initChart();
      } else {
        this.loadData(province);
      }
    },
    loadData(province) {
      $.get({
        url: `/api/v1/epidemic-data/${province}`,
        success: (data) => {
          const color = this.getRandomColor();
          this.datasets.push({
            label: data.province.label,
            data: data.total_cases,
            initials: data.province.initials,
            fill: false,
            backgroundColor: color,
            borderColor: color
          });
          this.initChart();
        }
      })
    },
    initChart() {
      Vue.nextTick(() => {
        const ctx = document.getElementById("provinces-chart").getContext('2d');
        this.chart = new Chart(ctx, {
          type: 'line',
          data: this.chartData,
          options: this.chartOptions
        });
      });
    },
    getRandomColor() {
      const letters = '0123456789ABCDEF';
      let color = '#';
      for (var i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
      }
      return color;
    }
  }
}
</script>

<template>
  <div id="province" class="container">
    <h1 class="text-center my-5">Great title - Covid-19</h1>

    <div class="my-5">
      <button class="btn btn-primary w-100 text-center" type="button" data-toggle="collapse" data-target="#chooseProvinces" aria-expanded="false" aria-controls="chooseProvinces">
        Choose province to show
      </button>
      <div class="collapse" id="chooseProvinces">
        <div class="card card-body p-4">
          <div v-for="(region, region_index) in nation.regions" :key="`region-${region.code}`" class="py-2">
            <a data-toggle="collapse" :href="`#collapse-region-${region.code}`" aria-expanded="false" :aria-controls="`collapse-region-${region.code}`">
              {{region.label}}
            </a>
            <div :id="`collapse-region-${region.code}`" class="collapse">
              <div class="py-4 d-flex flex-wrap">
                <button
                  v-for="(province, province_index) in region.provinces"
                  :key="`province-${province.initials}`"
                  class="btn m-2"
                  @click="toggleProvince(province.initials)"
                  :class="isProvinceDrawned(province.initials) ? 'btn-primary' : 'btn-outline-primary'"
                >
                  {{province.label}}
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="ar-16by9 w-100 position-relative">
      <canvas id="provinces-chart" class="position-absolute-center"></canvas>
    </div>
  </div>
</template>

<style lang="scss">
</style>