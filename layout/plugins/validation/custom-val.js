jQuery.validator.addMethod("rut", function(value, element) {
    return /^([0-9]{7,8}|([0-9]{1,2}\.[0-9]{3}\.[0-9]{3}))\-([0-9]|[Kk])$/.test(value);
}, "RUT inválido");

jQuery.validator.addMethod("dias", function (value, element) {
    var r = false;
    if (($("input[name*='CodDiaAtencion']:checked").length) <= 0) {
        return false;
    }
    return true;
}, "Debe escoger al menos un día");