function verificarLogin() {

    if (sessionStorage.getItem("logado") !== "true") {

        window.location = "../login.html";
    }
}