<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Producto Eliminado</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <meta charset="UTF-8">
</head>
<body>
<div class="container mt-5">
    <div class="alert alert-success" role="alert">
        El producto con ID <strong>${idprod}</strong> fue eliminado correctamente.
    </div>
    <a href="panelProductos.htm" class="btn btn-primary">Volver al Panel de Productos</a>
</div>
</body>
</html>>
