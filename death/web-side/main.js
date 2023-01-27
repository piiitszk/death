$(() => {
    window.addEventListener("message", function(event){
        let action = event.data.action
        let text = event.data.text


        if (action === "hide"){
            $("body").fadeOut(300)
            $("body").css("display","none")
        } else {
            $("body").css("display","block")
            $(".timer").html(text)
        }
    })
})