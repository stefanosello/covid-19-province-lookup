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
  <div class="w-100 px-3 d-flex justify-content-between align-items-center" navbar-component>
    <div><div class="font-weight-bold">Covid-19</div> <div class="small">Province Lookup</div></div>
    <button class="btn btn-dark btn-sm font-weight d-lg-none" @click="$emit('open-sidebar')">SELEZIONA PROVINCE</button>
  </div>
</template>

<style lang="scss">
[navbar-component] {
  height: 6rem;
  background-color: $gray-700;
  color: white;
}
</style>