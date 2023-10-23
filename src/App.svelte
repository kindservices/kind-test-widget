<svelte:options tag="kind-test-widget-app" />

<script lang="ts">
  import KindTest from './lib/KindTest.svelte'
</script>

<main>
  <div class="card">
    <KindTest param_one="Kind Test value set in App.svelte" />
  </div>

</main>