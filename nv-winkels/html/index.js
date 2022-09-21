$(function () {
    function display(bool) {
        if (bool) {
            $("#shopMenu").show();
        } else {
            $("#shopMenu").hide();
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

    $(".close").click(function () {
        $.post('http://nv-winkels/exit', JSON.stringify({}));
    })

    $("#slot1").click(function () {
        $.post('http://nv-winkels/brood', JSON.stringify({}));
        return
    })

    $("#slot2").click(function () {
        $.post('http://nv-winkels/water', JSON.stringify({}));
        return
    })

    $("#telefoon").click(function () {
        $.post('http://nv-winkels/telefoon', JSON.stringify({}));
        return
    })

    $("#hengel").click(function () {
        $.post('http://nv-winkels/hengel', JSON.stringify({}));
        return
    })

    $("#schroevendraaier").click(function () {
        $.post('http://nv-winkels/schroevendraaier', JSON.stringify({}));
        return
    })
})

$(document).on('keydown', function () {
    switch (event.keyCode) {
        case 27: // ESC
        $.post('http://nv-winkels/exit', JSON.stringify({}));
            break;
    }
});

