
var actual = 0;

/*Funciones genericas*/
function Failure(error) {
    alert("Error interno del servidor");
}

/*Manejo de Moleculas*/
function MostrarDialogoMoleculas() {
    $("#contenido_txtNomMolecula").val("");
    $("#contenido_txtConstDifusion").val("");
    $("#contenido_txtConstDifusion2d").val("");
    $("#contenido_txtCant").val("");
    $("#editFormMoleculas").show();
}

function CerrarDialogoMoleculas() {
    $("#editFormMoleculas").hide();    
}

function borrarMolecula(event) {
    var nombre = event.currentTarget.parentElement.parentElement.firstChild.textContent;
    PageMethods.borrarMolecula_Click(nombre);
    event.currentTarget.parentElement.parentElement.remove();
}

function borrarReaccion(event) {
    var nombre = event.currentTarget.parentElement.parentElement.firstChild.textContent;
    PageMethods.borrarReaccion_Click(nombre);
    event.currentTarget.parentElement.parentElement.remove();
}


function aceptarMolecula() {
    var nombre = $("#contenido_txtNomMolecula").val();
    var difusion = $("#contenido_txtConstDifusion").val();
    var difusion2d = $("#contenido_txtConstDifusion2d").val();
    var cantidad = $("#contenido_txtCant").val();

    var parametros = nombre + "," + difusion + "," + difusion2d + "," + cantidad;
    PageMethods.agregarMolecula_Click(parametros, SuccessMoleculas, Failure);
}

function SuccessMoleculas(result) {
    var nombre = $("#contenido_txtNomMolecula").val();
    var difusion = $("#contenido_txtConstDifusion").val();
    var difusion2d = $("#contenido_txtConstDifusion2d").val();
    var cantidad = $("#contenido_txtCant").val();

    $('#contenido_tablaMoleculas tbody').append("<tr>"
        + "<td><span id='nombreMoleculaValue' />"+nombre+"</td>"
        + "<td><span id='constanteDifusionValue' />"+difusion+"</td>"
        + "<td><span id='constanteDifusionValue2d' />"+difusion2d+"</td>"
        + "<td><span id='cantidad' />"+cantidad+"</td>"
        + "<td><img src='/Images/delete.png' class='btnDelete' style='width: 20px;'/></td></tr>");
    $(".btnDelete").bind("click", borrarMolecula);

    CerrarDialogoMoleculas();
}


/*Manejo de Reacciones*/
function MostrarDialogoReacciones() {
    $("#contenido_txtNomReaccion").val("");
    $("#contenido_txtReaccion").val("");
    $("#contenido_txtInicio").val("");
    $("#contenido_txtFin").val("");
    $("#contenido_txtStep").val("");
    $("#editFormReacciones").show();
}

function CerrarDialogoReacciones() {
    $("#editFormReacciones").hide();
}

function aceptarReaccion() {
    var nombre = $("#contenido_txtNomReaccion").val();
    var reaccion = $("#contenido_txtReaccion").val();
    var inicio = $("#contenido_txtInicio").val();
    var fin = $("#contenido_txtFin").val();
    var step = $("#contenido_txtStep").val();

    var parametros = nombre + "," + reaccion + "," + inicio + "," + fin + "," + step;
    PageMethods.agregarReaccion_Click(parametros, SuccessReaccion, Failure);
}

function SuccessReaccion(result) {
    var nombre = $("#contenido_txtNomReaccion").val();
    var reaccion = $("#contenido_txtReaccion").val();
    var inicio = $("#contenido_txtInicio").val();
    var fin = $("#contenido_txtFin").val();
    var step = $("#contenido_txtStep").val();

    $('#contenido_tablaReacciones tbody').append("<tr>"
        + "<td><span/>" + nombre + "</td>"
        + "<td><span/>" + reaccion + "</td>"
        + "<td><span/>" + inicio + "</td>"
        + "<td><span/>" + fin + "</td>"
        + "<td><span/>" + step + "</td>"
        + "<td><img src='/Images/delete.png' class='btnDelete' style='width: 20px;'/></td></tr>");
    $(".btnDelete").bind("click", borrarReaccion);

    CerrarDialogoReacciones();
}

function simularEjecucion() {
    $("#contenido_simular").hide();
    $(".simulationLoader").show();    

    var iterations = $("#contenido_iterationsValue").val();
    var timeStep = $("#contenido_timeStepValue").val();
    var aspectRatio = $("#contenido_aspectRatioValue").val();
    var nameList = $("#contenido_nameListValue").val();
    var x1 = $("#contenido_x1").val(); var x2 = $("#contenido_x2").val();
    var y1 = $("#contenido_y1").val(); var y2 = $("#contenido_y2").val();
    var z1 = $("#contenido_z1").val(); var z2 = $("#contenido_z2").val();
    var fernetMode = $("#contenido_fernetMode").val();

    var parametros = iterations + "|" + timeStep + "|" + aspectRatio + "|" + nameList + "|"
                           + x1 + "|" + y1 + "|" + z1 + "|" + x2 + "|" + y2 + "|" + z2 + "|"
                           + fernetMode;
    PageMethods.simular_Click(parametros, SuccessSimulation, Failure);
}

function SuccessSimulation(id) {
    $("#contenido_mensajeExito").text("Se estan procesando los datos para la simulacion, puede consultar los resultados con el Id: " + id);
    $("#mensajeConfirmacion").show();
    $('html,body').animate({
        scrollTop: ($("#mensajeConfirmacion").offset().top - 70)
    });

    $(".simulationLoader").hide();
    $("#contenido_simular").show();
}

function obtenerResultados() {
    var id = $("#contenido_IDSimulacion").val();

    $("#contenido_resultsTable").hide();
    $(".resultsLoader").show();

    PageMethods.obtenerResultados_Click(id, SuccessResultados, Failure);
}

function SuccessResultados(result) {
    result = $.parseJSON(result);    

    $('#contenido_resultsTable tr').not(function () { if ($(this).has('th').length) { return true } }).remove();
   
    if (result.length > 0) {
        $.each(result, function (i, item) {
            //Aun no empezaron a ejecutarse jobs en el cluster
            if (!item.showMdl && !item.showMcellOutput && !item.showResults) {
                $('#contenido_resultsTable tbody').append("<tr>"
                + "<td>" + item.IdUsuario + "</td>"
                + "<td>" + item.estado + "</td>"
                + "<td></td>"
                + "<td></td>"
                + "<td></td></tr>");

            }
            //Ya hay jobs corriendo en el cluster
            else {
                var mdl = "<td></td>";
                if (item.showMdl) {
                    mdl = "<td style='padding-left:30px'><a href='#' onclick='downloadMDL(" + item.IdUsuario + "," + item.IdJob + "); return false;' ><img src='/Images/download.png' class='btnDelete' style='width: 18px;'/></a></td>";
                }

                var mcellOutput = "<td></td>";
                if (item.showMcellOutput) {
                    mcellOutput = "<td style='padding-left:30px'><a href='#' onclick='downloadMcellOutput(" + item.IdUsuario + "," + item.IdJob + "); return false;'><img src='/Images/download.png' style='width: 18px;'/></a></td>";
                }

                var result = "<td></td></tr>";
                if (item.showResults) {
                    result = "<td style='padding-left:30px'><a href='#' onclick='downloadResults(" + item.IdUsuario + "," + item.IdJob + "); return false;'><img src='/Images/download.png' class='btnDelete' style='width: 18px;'/></a></td></tr>";
                }

                $('#contenido_resultsTable tbody').append("<tr>"
                    + "<td>" + item.IdUsuario + "." + item.IdJob + "</td>"
                    + "<td>" + item.estado + "</td>"
                    + mdl
                    + mcellOutput
                    + result );                
            }
        });

        $('#contenido_resultsTable').show();
        $('#contenido_noResultsLabel').hide();
        
    } else {
        $('#contenido_resultsTable').hide();
        $('#contenido_noResultsLabel').show();
    }

    $(".resultsLoader").hide();
    $("#contenido_resultsTable").show();
    
}

function downloadMcellOutput(userId, jobId) {   
    PageMethods.downloadMcellOutput_Click(userId, jobId, SuccessDownload, Failure);
}

function downloadResults(userId, jobId) {
    PageMethods.downloadResults_Click(userId, jobId, SuccessDownload, Failure);
}

function downloadMDL(userId, jobId) {
    PageMethods.downloadJobMDL_Click(userId, jobId, SuccessDownload, Failure);
}

function SuccessDownload(url) {

    if (url != "") {
        actual = (actual + 1) % 3;
        var link = $("#downloadLink_"+actual);
        link.attr("href", url);
        window.location = link.attr('href');
    }
}

$( function () {
    $('#contenido_tablaMoleculas tbody').append("<tr>"
        + "<td><span id='nombreMoleculaValue' />A</td>"
        + "<td><span id='constanteDifusionValue' />55e-08</td>"
        + "<td><span id='constanteDifusionValue2d' /></td>"
        + "<td><span id='cantidad' />200</td>"
        + "<td><img src='/Images/delete.png' class='btnDelete' style='width: 20px;'/></td></tr>");
    $(".btnDelete").bind("click", borrarMolecula);

    $('#contenido_tablaMoleculas tbody').append("<tr>"
        + "<td><span id='nombreMoleculaValue' />B</td>"
        + "<td><span id='constanteDifusionValue' />30e-08</td>"
        + "<td><span id='constanteDifusionValue2d' /></td>"
        + "<td><span id='cantidad' />200</td>"
        + "<td><img src='/Images/delete.png' class='btnDelete' style='width: 20px;'/></td></tr>");
    $(".btnDelete").bind("click", borrarMolecula);
    //reacciones
    //$('#contenido_tablaReacciones tbody').append("<tr>"
    //    + "<td><span/>Reaccion1</td>"
    //    + "<td><span/>A + B -> A</td>"
    //    + "<td><span/>1</td>"
    //    + "<td><span/>1</td>"
    //    + "<td><span/>1</td>"
    //    + "<td><img src='/Images/delete.png' class='btnDelete' style='width: 20px;'/></td></tr>");
    //$(".btnDelete").bind("click", borrarReaccion);

    //$('#contenido_tablaReacciones tbody').append("<tr>"
    //    + "<td><span/>Reaccion2</td>"
    //    + "<td><span/>A + A -> B</td>"
    //    + "<td><span/>3</td>"
    //    + "<td><span/>3</td>"
    //    + "<td><span/>1</td>"
    //    + "<td><img src='/Images/delete.png' class='btnDelete' style='width: 20px;'/></td></tr>");
    //$(".btnDelete").bind("click", borrarReaccion);

    //$('#contenido_tablaReacciones tbody').append("<tr>"
    //    + "<td><span/>Reaccion2</td>"
    //    + "<td><span/>A + A -> B</td>"
    //    + "<td><span/>1</td>"
    //    + "<td><span/>1</td>"
    //    + "<td><span/>1</td>"
    //    + "<td><img src='/Images/delete.png' class='btnDelete' style='width: 20px;'/></td></tr>");
    //$(".btnDelete").bind("click", borrarReaccion);

    //$('#contenido_tablaReacciones tbody').append("<tr>"
    //    + "<td><span/>Reaccion2</td>"
    //    + "<td><span/>A + A -> B</td>"
    //    + "<td><span/>1</td>"
    //    + "<td><span/>10</td>"
    //    + "<td><span/>1</td>"
    //    + "<td><img src='/Images/delete.png' class='btnDelete' style='width: 20px;'/></td></tr>");
    //$(".btnDelete").bind("click", borrarReaccion);

    //$('#contenido_tablaReacciones tbody').append("<tr>"
    //    + "<td><span/>Reaccion2</td>"
    //    + "<td><span/>A + A -> B</td>"
    //    + "<td><span/>1</td>"
    //    + "<td><span/>3</td>"
    //    + "<td><span/>1</td>"
    //    + "<td><img src='/Images/delete.png' class='btnDelete' style='width: 20px;'/></td></tr>");
    //$(".btnDelete").bind("click", borrarReaccion);

    //$('#contenido_tablaReacciones tbody').append("<tr>"
    //    + "<td><span/>Reaccion2</td>"
    //    + "<td><span/>A + A -> B</td>"
    //    + "<td><span/>3</td>"
    //    + "<td><span/>5</td>"
    //    + "<td><span/>1</td>"
    //    + "<td><img src='/Images/delete.png' class='btnDelete' style='width: 20px;'/></td></tr>");
    //$(".btnDelete").bind("click", borrarReaccion);

});
