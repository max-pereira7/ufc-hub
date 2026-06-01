function verificarLogin() {

    if (sessionStorage.getItem("logado") !== "true") {

        window.location = "../login.html";
    }
}

function atualizarHeader() {

    if (sessionStorage.getItem("logado") === "true") {

        linkLogin.innerHTML = "Perfil";
        linkLogin.href = "../perfil.html";
    }
}