<script>
import { defineComponent } from "vue";
import { Doughnut } from "vue3-chart-v2";

export default defineComponent({
  name: "Doughnut",
  extends: Doughnut,
  props: {
    title: {
      type: String,
      required: true,
    },
    labels: {
      type: Array,
      required: true,
    },
    data: {
      type: Array,
      required: false,
    },
  },
  mounted() {
    const colors = () => {
      const part = 87979;
      const colors = [];
      for (let i = 0; i < this.data.length; i++) {
        let inc = (part + i * 35).toString();
        if (i.length > 5) {
          inc.slice(0, inc.length - 1);
        }
        colors.push("#f" + inc);
      }
      return colors;
    };

    // Overwriting base render method with actual data.
    this.renderChart(
      {
        labels: this.labels,
        datasets: [
          {
            label: this.title,
            backgroundColor: colors(),
            data: this.data,
          },
        ],
      },
      {
        responsive: false,
      }
    );
  },
});
</script>
