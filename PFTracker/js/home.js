var ctx = document.getElementById('expensePieChart').getContext('2d');
var expensePieChart = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: ['Supermercado', 'Automóvel', 'Transporte', 'Lazer'],
        datasets: [{
            data: [300, 500, 100, 150],
            backgroundColor: ['#007bff', '#6610f2', '#28a745', '#ffc107']
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                position: 'top',
            },
        }
    }
});
