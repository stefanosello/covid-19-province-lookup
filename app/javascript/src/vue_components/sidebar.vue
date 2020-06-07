<script type="text/javascript">
import { disableBodyScroll, clearAllBodyScrollLocks } from 'body-scroll-lock';

export default {
  props: {
    nation: {
      type: Object,
      default: () => {return {}}
    }
  },
  data() {
    return {
      regions: this.nation.regions,
      searchText: ""
    }
  },
  mounted() {
    disableBodyScroll(this.$el);
  },
  destroyed() {
    clearAllBodyScrollLocks();
  },
  computed: {},
  methods: {
    showRegion(region) {
      const textInRegionLabel = region.label.toLowerCase().includes(this.searchText);
      const textInProvincesLabel = Object.values(region.provinces).filter(province => {
        return province.label.toLowerCase().includes(this.searchText);
      }).length > 0;
      return textInRegionLabel || textInProvincesLabel;
    },
    toggleCollapsible(id) {
      $(`#${id}`).collapse("toggle");
    },
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
    <div class="card-body p-3 p-xl-5 position-relative">
      <div class="border-bottom mb-3">
        <span class="close-icon font-weight-bold cursor-pointer position-absolute" @click="$emit('close')">&times;</span>
        <div class="font-weight-bold mb-3"> IMPOSTAZIONI </div>
      </div>

      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text" id="search-addon">?</span>
        </div>
        <input type="text" class="form-control" placeholder="Cerca un luogo..." v-model="searchText" aria-label="search" aria-describedby="search-addon">
      </div>

      <div class="w-100 p-2 my-1 region-item" v-for="(region, region_index) in regions" :key="`region-${region.code}`" v-show="showRegion(region)">
        <a @click="toggleCollapsible(`${region_index}-collapse`)" data-toggle="collapse" class="cursor-pointer">
          {{region.label}}
        </a>

        <div :id="`${region_index}-collapse`" class="collapse">
          <div class="py-1">
            <div class="px-2" v-for="(province, province_index) in region.provinces" :key="`${province.initials}-${province.index}`">
              <div class="custom-control custom-switch">
                <input type="checkbox" class="custom-control-input" :id="`switch-${province.label}`" :checked="province.drawned" @click.stop.capture="toggleProvince(region_index, province_index)">
                <label class="custom-control-label" :for="`switch-${province.label}`">{{province.label}}</label>
              </div>
            </div>
          </div>      
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
[sidebar-component] {
  max-height: calc(100vh - 2rem);
  height: calc(100vh - 2rem);

  .card-body {
    height: 100%;
    max-height: 100%;
    overflow-y: auto;
    background-color: $gray-200;
    border-radius: .25rem;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.1), 0 6px 20px 0 rgba(0, 0, 0, 0.1);
  }

  .region-item {
    background-color: $gray-300;
    border-radius: .25rem;
  }

  .provinces-container {
    background-color: white;
    z-index: 1;
    width: 15rem;
  }

  #search-addon {
    background-color: $gray-300 !important;
  }

  .close-icon {
    right: 1rem;
    top: 1.5rem;
    font-size: 2rem;
    line-height: 0;
  }

  .btn-outline-secondary {
    background-color: rgba($secondary, .15);
  }
}
</style>