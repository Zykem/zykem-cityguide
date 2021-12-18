$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
            

            
        } else {
            $("#container").hide();
            $("#container2").hide();
        }
    }
    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
                
                
            } else {
                display(false)
                
            }
        }
    })

    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://zykem-cityguide/exit', JSON.stringify({}));
            return
        }
    };
    //when the user clicks on the submit button, it will run
    $("#cardealerbtn").click(function () {
        
        // if there are no errors from above, we can send the data back to the original callback and hanndle it from there
        $.post('http://zykem-cityguide/cardealerbtn');
        return;
        $.post('http://zykem-cityguide/exit', JSON.stringify({}));
    })
    $("#drivingschoolbtn").click(function () {
        
        // if there are no errors from above, we can send the data back to the original callback and hanndle it from there
        $.post('http://zykem-cityguide/drivingschoolbtn');
        return;
        $.post('http://zykem-cityguide/exit', JSON.stringify({}));
    })
    $("#hospitalbtn").click(function () {
        
        // if there are no errors from above, we can send the data back to the original callback and hanndle it from there
        $.post('http://zykem-cityguide/hospitalbtn');
        return;
        $.post('http://zykem-cityguide/exit', JSON.stringify({}));
    })
    $("#policebtn").click(function () {
        
        // if there are no errors from above, we can send the data back to the original callback and hanndle it from there
        $.post('http://zykem-cityguide/policebtn');
        return;
        $.post('http://zykem-cityguide/exit', JSON.stringify({}));
    })
    $("#rentbikebtn").click(function () {
        
        // if there are no errors from above, we can send the data back to the original callback and hanndle it from there
        $.post('http://zykem-cityguide/rentbikebtn');
        return;
        $.post('http://zykem-cityguide/exit', JSON.stringify({}));
    })

    // JOB NAVIGATION

    $("#pick1").click(function() {

        $.post('http://zykem-cityguide/job1')
        return;
        $.post('http://zykem-cityguide/exit', JSON.stringify({}));

    })

    $("#pick2").click(function() {

        $.post('http://zykem-cityguide/job2')
        return;
        $.post('http://zykem-cityguide/exit', JSON.stringify({}));

    })

    $("#pick3").click(function() {

        $.post('http://zykem-cityguide/job3')
        return;
        $.post('http://zykem-cityguide/exit', JSON.stringify({}));

    })

})

