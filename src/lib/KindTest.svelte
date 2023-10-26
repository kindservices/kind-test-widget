<svelte:options tag="kind-test-widget" />

<script lang="ts">
  let count: number = 0
  const increment = () => {
    count += 1
  }

  // note - we set param_one in our k8s/web.yaml
    export let param_one;
  </script>

  <main>
    <div class="card-container">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="card-title">
              <h2>{param_one}</h2>
            </div>
          </div>           
          <button on:click={increment}>
            test clicks: {count}
          </button>

        </div>
      </div>
    </div>
  </main>

  <style>
   .card {
      max-width: 350px;
      border-radius: 5px;
      box-shadow: 0 4px 6px 0 #00000033;
      padding: 0 0 10px 0;
    }

    .card-body {
      padding: 5px 10px;
    }

  </style>