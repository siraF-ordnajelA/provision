<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="error_404.aspx.cs" Inherits="medallia.error_404" %>

<html>
    <head id="Head1" runat="server">
        <title>Error 501</title>
        <link id="favicon" rel="icon" type="image/png" href="imagenes/Favempire_32_Black.png">
    </head>

    <style>
        div.principal {
            display: flex;
            align-items: center;
        }
        .central {
           line-height: 200px;
        }
    </style>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            document.body.style.backgroundColor = "black";
        });
    </script>

    <body>
        <form runat="server">
            <div class="principal>
                <div class="central>
                <center><img src="imagenes/sandtrooper_movealong.jpg" /></center>
                <br /><br />
                <a href="login.aspx"><U>VOLVER</U></a>
                </div>
            </div>
            <br />
        </form>
    </body>

</html>