<script type="text/javascript">

export default {
  data() {
    return { }
  },
  mounted() { },
  computed: { },
  methods: { }
}
</script>

<template>
  <div class="w-100 px-3 d-flex justify-content-between align-items-center sticky-top" navbar-component>
    <h1><div class="font-weight-bold">Covid-19</div> <div class="small">Province stats</div></h1>
    <button class="btn btn-dark btn-sm font-weight" @click="$emit('open-sidebar')">IMPOSTAZIONI</button>
  </div>
</template>

<style lang="scss">
[navbar-component] {
  height: $header-height;
  background-color: $gray-700;
  color: white;

  h1 {
    font-size: 1rem;
  }
}
</style>