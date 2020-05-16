window.draw_graph = ->
    ctx = document.getElementById("myChart").getContext('2d')
    barNum = gon.data_incomes.length
    labels = new Array(barNum)
    incom_bgColors = new Array(barNum)
    incom_bdColors = new Array(barNum)
    fixed_bgColors = new Array(barNum)
    fixed_bdColors = new Array(barNum)
    variable_bgColors = new Array(barNum)
    variable_bdColors = new Array(barNum)
    result_bgColors = new Array(barNum)
    result_bdColors = new Array(barNum)
 
 
    for i in [0...gon.data_incomes.length]
        labels[i] = i+1 +'月'
        incom_bgColors[i] = 'rgba(135, 201, 164, 0.2)'
        incom_bdColors[i] = 'rgba(135, 201, 164, 1)'
        fixed_bgColors[i] = 'rgba(247, 176, 44, 0.2)'
        fixed_bdColors[i] = 'rgba(247, 176, 44, 1)'
        variable_bgColors[i] = 'rgba(233, 77, 55, 0.2)'
        variable_bdColors[i] = 'rgba(233, 77, 55, 1)'
        result_bgColors[i] = 'rgba(0, 134, 186, 0.2)'
        result_bdColors[i] = 'rgba(0, 134, 186, 1)'
 
 
    myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels
            datasets: [{
                label: '収入合計値',
                data: gon.data_incomes,
                backgroundColor: incom_bgColors,
                borderColor: incom_bdColors,
                borderWidth: 1
            },{
                label: '固定費合計値',
                data: gon.data_fixedcosts,
                backgroundColor: fixed_bgColors,
                borderColor: fixed_bdColors,
                borderWidth: 1,
                type: 'bar'
              },{
                label: '変動費合計値',
                data: gon.data_variablecosts,
                backgroundColor: variable_bgColors,
                borderColor: variable_bdColors,
                borderWidth: 1,
                type: 'bar'
            },{
                label: '収支結果合計値',
                data: gon.data_results,
                backgroundColor: result_bgColors,
                borderColor: result_bdColors,
                borderWidth: 1,
                type: 'bar'
              }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    })