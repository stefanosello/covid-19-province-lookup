<script type="text/javascript">

export default {
  props: {
    nation: {
      type: Object,
      default: () => {return {}}
    }
  },
  data() {
    return {
      regions: this.nation.regions
    }
  },
  mounted() { },
  computed: { },
  methods: {
    toggleProvince(region_index, province_index) {
      let province = this.regions[region_index].provinces[province_index];
      if(province.drawned) {
        Vue.set(province, 'drawned', false);
        this.$emit("remove-province", province);
      } else {
        Vue.set(province, 'drawned', true);
        this.$emit("add-province", province);
      }
    }
  }
}
</script>

<template>
  <div class="w-100" sidebar-component>
    <div class="card-body p-3 p-xl-5 d-flex flex-wrap position-relative">
      <span class="close-icon font-weight-bold cursor-pointer position-absolute d-lg-none" @click="$emit('close')">&times</span>
      <h4 class="font-weight-bold pr-4"> Seleziona le province di interesse</h4>
      <div v-for="(region, region_index) in regions" :key="`region-${region.code}`" class="dropdown">
        <button data-toggle="dropdown" class="btn btn-secondary font-weight-bold m-2 dropdown-toggle">
          {{region.label}}
        </button>
        <div class="dropdown-menu">
          <div class="px-2" v-for="(province, province_index) in region.provinces">
            <div class="custom-control custom-checkbox">
              <input type="checkbox" class="custom-control-input" :id="`checkbox-${province.label}`" :checked="province.drawned" @click.stop.capture="toggleProvince(region_index, province_index)">
              <label class="custom-control-label" :for="`checkbox-${province.label}`">{{province.label}}</label>
            </div>
          </div>        
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
[sidebar-component] {
  border-left: 1px solid $gray-600;
  max-height: 100vh;
  height: 100vh;

  .card-body {
    height: 100%;
    max-height: 100%;
    overflow-y: auto;
    background-color: $gray-200;
  }

  .provinces-container {
    background-color: white;
    z-index: 1;
    width: 15rem;
  }

  .close-icon {
    right: 1rem;
    top: 1.5rem;
    font-size: 2rem;
    line-height: 0;
  }
}
</style>