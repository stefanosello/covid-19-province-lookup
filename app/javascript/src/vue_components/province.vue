<script type="text/javascript">
export default {
  props: {
    data : {
      type: Object,
      default: () => {return {}}
    }
  },
  data() {
    return { }
  },
  mounted() {
    console.log("province mounted");
  }
}
</script>

<template>
  <div id="province">
    {{data}}
  </div>
</template>

<style lang="scss">
  
</style>