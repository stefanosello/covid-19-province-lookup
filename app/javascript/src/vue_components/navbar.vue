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
    <div class="d-flex align-items-center">
      <img src="/favicon.png" class="icon"/>
      <h1 class="ml-2"><div class="font-weight-bold">Covid-19</div> <div class="small">Province stats</div></h1>
    </div>
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

  .icon {
    max-height: calc(#{$header-height} - 2rem);
    width: auto;
  }
}
</style>