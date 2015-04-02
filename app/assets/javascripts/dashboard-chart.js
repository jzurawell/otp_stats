window.onload = function () {
    
    if (window.location.pathname === '/') {
        console.log(GRAPH_DATA);
    

        var canvas = document.getElementById('mycanvas')
        var ctx = canvas.getContext('2d')
        var options = {}
        var data = {
            labels: ["Approvals", "Reviews", "Translations", "Transcriptions"],
            datasets: [
                {
                    label: "My First dataset",
                    fillColor: "rgba(220,220,220,0.5)",
                    strokeColor: "rgba(220,220,220,0.8)",
                    highlightFill: "rgba(220,220,220,0.75)",
                    highlightStroke: "rgba(220,220,220,1)",
                    data: GRAPH_DATA
                }
            ]
        };
        var myBarChart = new Chart(ctx).Bar(data, options);
    }
}