$(document).ready(function() {
  $("#active-customer").on("click", function(){
    $.ajax({
      url: 'http://localhost:3000/api/v1/most_active_customers',
      headers: {
          "Authorization": "Basic " + btoa('admin:admin')
      },
      success: function(data) {
        var customers = [data[0][0], data[1][0], data[2][0], data[3][0], data[4][0]]
        var customersSpent = [data[0][1], data[1][1], data[2][1], data[3][1], data[4][1]]
        $(".left-table-head").text("Customer");
        $(".right-table-head").text("Money Spent");
        $(".first-left-td").text(customers[0]);
        $(".first-right-td").text("$" + customersSpent[0]);
        $(".second-left-td").text(customers[1]);
        $(".second-right-td").text("$" + customersSpent[1]);
        $(".third-left-td").text(customers[2]);
        $(".third-right-td").text("$" + customersSpent[2]);
        $(".fourth-left-td").text(customers[3]);
        $(".fourth-right-td").text("$" + customersSpent[3]);
        $(".fifth-left-td").text(customers[4]);
        $(".fifth-right-td").text("$" + customersSpent[4]);
      },
      error: function (xhr,ajaxOptions,throwError){
        console.log("An error has occured.")
      }
    });
  });

  $("#expensive-orders").on("click", function(){
    $.ajax({
      url: 'http://localhost:3000/api/v1/most_expensive_orders',
      headers: {
          "Authorization": "Basic " + btoa('admin:admin')
      },
      success: function(data) {
        var customers = [data[0][0], data[1][0], data[2][0], data[3][0], data[4][0]]
        var customersSpent = [data[0][1], data[1][1], data[2][1], data[3][1], data[4][1]]
        $(".left-table-head").text("Order");
        $(".right-table-head").text("Order Total");
        $(".first-left-td").text(customers[0]);
        $(".first-right-td").text("$" + customersSpent[0]);
        $(".second-left-td").text(customers[1]);
        $(".second-right-td").text("$" + customersSpent[1]);
        $(".third-left-td").text(customers[2]);
        $(".third-right-td").text("$" + customersSpent[2]);
        $(".fourth-left-td").text(customers[3]);
        $(".fourth-right-td").text("$" + customersSpent[3]);
        $(".fifth-left-td").text(customers[4]);
        $(".fifth-right-td").text("$" + customersSpent[4]);
      },
      error: function (xhr,ajaxOptions,throwError){
        console.log("An error has occured.")
      }
    });
  });

  $("#most-sold").on("click", function(){
    $.ajax({
      url: 'http://localhost:3000/api/v1/most_sold_items',
      headers: {
          "Authorization": "Basic " + btoa('admin:admin')
      },
      success: function(data) {
        var customers = [data[0][0], data[1][0], data[2][0], data[3][0], data[4][0]]
        var customersSpent = [data[0][1], data[1][1], data[2][1], data[3][1], data[4][1]]
        $(".left-table-head").text("Item");
        $(".right-table-head").text("Quantity");
        $(".first-left-td").text(customers[0]);
        $(".first-right-td").text(customersSpent[0]);
        $(".second-left-td").text(customers[1]);
        $(".second-right-td").text(customersSpent[1]);
        $(".third-left-td").text(customers[2]);
        $(".third-right-td").text(customersSpent[2]);
        $(".fourth-left-td").text(customers[3]);
        $(".fourth-right-td").text(customersSpent[3]);
        $(".fifth-left-td").text(customers[4]);
        $(".fifth-right-td").text(customersSpent[4]);
      },
      error: function (xhr,ajaxOptions,throwError){
        console.log("An error has occured.")
      }
    });
  });

  $("#top-selling-items").on("click", function(){
    $.ajax({
      url: 'http://localhost:3000/api/v1/top_selling_items',
      headers: {
          "Authorization": "Basic " + btoa('admin:admin')
      },
      success: function(data) {
        var customers = [data[0][0], data[1][0], data[2][0], data[3][0], data[4][0]]
        var customersSpent = [data[0][1], data[1][1], data[2][1], data[3][1], data[4][1]]
        $(".left-table-head").text("Item");
        $(".right-table-head").text("Revenue Earned");
        $(".first-left-td").text(customers[0]);
        $(".first-right-td").text("$" + customersSpent[0]);
        $(".second-left-td").text(customers[1]);
        $(".second-right-td").text("$" + customersSpent[1]);
        $(".third-left-td").text(customers[2]);
        $(".third-right-td").text("$" + customersSpent[2]);
        $(".fourth-left-td").text(customers[3]);
        $(".fourth-right-td").text("$" + customersSpent[3]);
        $(".fifth-left-td").text(customers[4]);
        $(".fifth-right-td").text("$" + customersSpent[4]);
      },
      error: function (xhr,ajaxOptions,throwError){
        console.log("An error has occured.")
      }
    });
  });

  $("#top-selling-stores").on("click", function(){
    $.ajax({
      url: 'http://localhost:3000/api/v1/top_selling_stores',
      headers: {
          "Authorization": "Basic " + btoa('admin:admin')
      },
      success: function(data) {
        var customers = [data[0][0], data[1][0], data[2][0], data[3][0], data[4][0]]
        var customersSpent = [data[0][1], data[1][1], data[2][1], data[3][1], data[4][1]]
        $(".left-table-head").text("Store");
        $(".right-table-head").text("Revenue Earned");
        $(".first-left-td").text(customers[0]);
        $(".first-right-td").text("$" + customersSpent[0]);
        $(".second-left-td").text(customers[1]);
        $(".second-right-td").text("$" + customersSpent[1]);
        $(".third-left-td").text(customers[2]);
        $(".third-right-td").text("$" + customersSpent[2]);
        $(".fourth-left-td").text(customers[3]);
        $(".fourth-right-td").text("$" + customersSpent[3]);
        $(".fifth-left-td").text(customers[4]);
        $(".fifth-right-td").text("$" + customersSpent[4]);
      },
      error: function (xhr,ajaxOptions,throwError){
        console.log("An error has occured.")
      }
    });
  });
});