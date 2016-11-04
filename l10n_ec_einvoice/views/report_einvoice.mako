<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <style>
    .invoice-box{
        max-width:800px;
        margin:auto;
        padding:30px;
        border:1px solid #eee;
        box-shadow:0 0 10px rgba(0, 0, 0, .15);
        font-size:16px;
        line-height:24px;
        font-family:'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
        color:#555;
    }

    .invoice-box table{
        width:100%;
        line-height:inherit;
        text-align:left;
    }

    .invoice-box table td{
        padding:5px;
        vertical-align:top;
    }

    .invoice-box table tr td:nth-child(2){
        text-align:right;
    }

    .invoice-box table tr.top table td{
        padding-bottom:20px;
    }

    .invoice-box table tr.top table td.title{
        font-size:12px;
        line-height:45px;
        color:#333;
    }

    .invoice-box table tr.information table td{
        padding-bottom:40px;
    }

    .invoice-box table tr.information table td.right{
        float: right;
        text-align: center;
    }

    .invoice-box table tr.heading td{
        background:#eee;
        border-bottom:1px solid #ddd;
        font-weight:bold;
    }

    .invoice-box table tr.details td{
        padding-bottom:20px;
        text-align: right;
    }

    .invoice-box table tr.item td{
        border-bottom:1px solid #eee;
        text-align: right;
    }

    .invoice-box table tr.items{
        text-align: right;
    }

    .invoice-box table tr.separator{
        margin: 50px;
    }

    .invoice-box table tr.item.last td{
        border-bottom:none;
    }

    .invoice-box table tr.total td:nth-child(3){
        border-top:2px solid #eee;
        font-weight:bold;
        text-align: right;
    }

    .invoice-box table tr.total td:nth-child(2){
        border-top:2px solid #eee;
        font-weight:bold;
        text-align: right;
    }

    .invoice-box table tr.inner{
        border-top: none;
        border-bottom: none;
        font-weight:bold;
        text-align: right;
    }

    @media only screen and (max-width: 600px) {
        .invoice-box table tr.top table td{
            width:100%;
            display:block;
            text-align:center;
        }

        .invoice-box table tr.information table td{
            width:100%;
            display:block;
            text-align:center;
        }
    }
    </style>
</head>

<body>
      %for o in objects:
    <div class="invoice-box">
        <table cellpadding="0" cellspacing="0">
            <tr class="top">
                <td colspan="6">
                    <table>
                        <tr>
                            <td>
                                <img src="data:image/png;base64,${company.logo}" style="width:100%; max-width:300px;">
                            </td>

                            <td>
                              ${o.company_id.name.upper()}<br>
                              ${ o.company_id.street } ${ o.company_id.street2 or ""}<br>
                              <strong>Contribuyente Especial Nro:</strong> ${o.company_id.company_registry or ""} <br>
                              <strong>Obligado a llevar contabilidad:</strong> ${o.company_id.keep_accounts and 'Si' or 'No'}
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr class="information">
                <td colspan="6">
                    <table>
                        <tr>
                            <td colspan="2">
                              <strong>Ruc:</strong> ${o.company_id.partner_id.ced_ruc}<br>
                              <strong>Factura No.:</strong> ${ o.invoice_number or ""}<br>
                              <strong>Numero de autorizacion:</strong> ${ o.numero_autorizacion or ""}<br>
                              <strong>Fecha de autorizacion:</strong> ${ o.fecha_autorizacion or ""}<br>
                            </td>
                            <td class="right" colspan="2">
                              <strong>Ambiente:</strong> ${ o.company_id.env_service=='1' and 'PRUEBAS' or 'PRODUCCION' }<br>
                              <strong>Clave acceso:</strong> <br>
                              ${ helper.barcode(o.clave_acceso, htmlAttrs={'width': '350px', 'height': '30px;'}) | safe}<br>
                              ${ o.clave_acceso or "" } <br>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr class="heading">
                <td colspan="3">
                    Cliente
                </td>
                <td>
                    RUC/CI
                </td>
                <td>
                    Fecha de emisi&oacuten
                </td>
                <td>
                    Guia de remisi&oacuten
                </td>
            </tr>
            <tr class="details">
                <td colspan="3">
                    ${ o.partner_id.name.upper() }
                </td>
                <td>
                    ${ o.partner_id.ced_ruc }
                </td>
                <td>
                    ${ o.date_invoice }
                </td>
                <td>
                    ${ o.date_invoice }
                </td>
            </tr>
            <tr class="separator"></tr>

            <tr class="heading items">
                <td>
                    C&oacutedigo
                </td>
                <td>
                    Descripci&oacuten
                </td>
                <td>
                    Cantidad
                </td>
                <td>
                    Precio
                </td>
                <td>
                    Descuento
                </td>
                <td>
                    Total
                </td>
            </tr>
            %for line in o.invoice_line:
              %if o.invoice_line[-1] != line:
                <tr class="item">
                  <td>
                    ${ line.product_id.default_code or '**' }
                  </td>
                  <td>
                    ${ line.product_id.name }
                  </td>
                  <td>
                    ${ '%.2f'%line.quantity }
                  </td>
                  <td>
                    ${ '%.2f'%line.price_unit }
                  </td>
                  <td>
                    0.00
                  </td>
                  <td>
                    ${ '%.2f'%line.price_subtotal }
                  </td>
                </tr>
              %else:
                <tr class="item last">
                  <td>
                    ${ line.product_id.default_code or '**' }
                  </td>
                  <td>
                    ${ line.product_id.name }
                  </td>
                  <td>
                    ${ '%.2f'%line.quantity }
                  </td>
                  <td>
                    ${ '%.2f'%line.price_unit }
                  </td>
                  <td>
                    0.00
                  </td>
                  <td>
                    ${ '%.2f'%line.price_subtotal }
                  </td>
                </tr>
              %endif
            %endfor
            <tr>
              <td>
                <br>
                <br>
              </td>
            </tr>
            <tr class="inner">
              <td colspan="3">
              </td>
                <td colspan="2">
                    SUBTOTAL 14%
                </td>
                <td colspan="1">
                    ${ '%.2f'% o.amount_vat }
                </td>
            </tr>
            <tr class="inner">
              <td colspan="3">
              </td>
                <td colspan="2">
                    SUBTOTAL 0%
                </td>
                <td colspan="1">
                    ${ '%.2f'% o.amount_vat_cero }
                </td>
            </tr>
            <tr class="inner">
              <td colspan="3"> </td>
                <td colspan="2">
                    SUBTOTAL no sujeto IVA
                </td>
                <td colspan="1">
                    ${ '%.2f'% o.amount_novat }
                </td>
            </tr>
            <tr class="inner">
              <td colspan="3"> </td>
                <td colspan="2">
                    SUBTOTAL SIN IMPUESTOS
                </td>
                <td colspan="1">
                    ${ '%.2f'% o.amount_untaxed }
                </td>
            </tr>
            <tr class="inner">
              <td colspan="3"> </td>
                <td colspan="2">
                    DESCUENTOS
                </td>
                <td colspan="1">
                    0.00
                </td>
            </tr>
            <tr class="inner">
              <td colspan="3"> </td>
                <td colspan="2">
                    ICE
                </td>
                <td colspan="1">
                    0.00
                </td>
            </tr>
            <tr class="inner">
              <td colspan="3"> </td>
                <td colspan="2">
                    IVA 14%
                </td>
                <td colspan="1">
                    ${ '%.2f'% o.amount_tax }
                </td>
            </tr>
            <tr class="inner">
              <td colspan="3"></td>
                <td colspan="2">
                    PROPINA
                </td>
                <td colspan="1">
                    0.00
                </td>
            </tr>
            <tr class="total">
              <td colspan="3"> </td>
                <td colspan="2">
                    VALOR TOTAL
                </td>
                <td colspan="1">
                    ${ '%.2f'% o.amount_pay }
                </td>
            </tr>
        </table>
    </div>
    %endfor
</body>
</html>
