<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/jsp/panelproducto/menuAdmin.jsp" %>

<c:if test="${sessionScope.usuario != null && sessionScope.usuario.role == 'ADMIN'}">
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Mensajes de Contacto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background: #f8f9fa;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        table {
            font-size: 0.95rem;
        }
        th {
            background: #0d6efd;
            color: white;
            text-align: center;
        }
        td {
            vertical-align: middle;
        }
    </style>
</head>
<body>

<div class="container mt-4">
    <h2 class="mb-4 text-center">📩 Contactos recibidos</h2>

    <c:if test="${empty contactos}">
        <div class="alert alert-warning text-center">No hay mensajes registrados.</div>
    </c:if>

    <c:if test="${not empty contactos}">
        <div class="table-responsive">
            <table class="table table-bordered table-striped align-middle text-center">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Correo</th>
                        <th>Mensaje</th>
                        <th>Fecha</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${contactos}">
                        <tr>
                            <td>${c.nombre}</td>
                            <td>${c.correo}</td>
                            <td class="text-start">${c.mensaje}</td>
                            <td>${c.fecha}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/eliminarContacto.htm?id=${c.id}" 
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('¿Eliminar este contacto?')">
                                    🗑 Eliminar
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
</div>

</body>
</html>
</c:if>

<c:if test="${sessionScope.usuario == null || sessionScope.usuario.role != 'ADMIN'}">
    <div class="container mt-5">
        <div class="alert alert-danger text-center">
            🚫 No tienes permisos para acceder a esta sección.
        </div>
    </div>
</c:if>
