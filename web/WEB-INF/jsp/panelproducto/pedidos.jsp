<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/jsp/panelproducto/menuAdmin.jsp" %>

<c:if test="${sessionScope.usuario != null && sessionScope.usuario.role == 'ADMIN'}">
<!DOCTYPE html>
<html>
<head>
    <title>Panel de Pedidos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .pedido {
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f9f9f9;
        }
        .pedido h3 {
            margin-top: 0;
            color: #333;
        }
        .detalle-producto {
            margin-left: 20px;
            margin-top: 10px;
        }
        .detalle-producto ul {
            list-style: none;
            padding: 0;
        }
        .detalle-producto li {
            padding: 5px 0;
            border-bottom: 1px dashed #ccc;
        }
        .detalle-producto li:last-child {
            border-bottom: none;
        }
        .campo {
            margin-bottom: 8px;
        }
        .campo strong {
            width: 130px;
            display: inline-block;
            color: #555;
        }
    </style>
</head>
<body>

<h2 style="text-align: center;">Listado de Pedidos</h2>

<c:if test="${empty pedidos}">
    <div class="alert alert-info text-center">No hay pedidos registrados.</div>
</c:if>

<c:forEach var="p" items="${pedidos}">
    <div class="pedido">
        <h3>Pedido #${p.idpedido}</h3>
        <div class="campo"><strong>ID Usuario:</strong> ${p.usuario_id}</div>
        <div class="campo"><strong>Contacto:</strong> ${p.contacto}</div>
        <div class="campo"><strong>Destino:</strong> ${p.destino}</div>
        <div class="campo"><strong>Ubicación:</strong> ${p.ubicacion}</div>
        <div class="campo"><strong>Total:</strong> S/. ${p.total}</div>
        <div class="campo"><strong>Fecha:</strong> ${p.fecha}</div>

        <div class="detalle-producto">
            <strong>Productos:</strong>
            <ul>
                <c:forEach var="detalle" items="${p.detalles}">
                    <li>
                        ${detalle.nombre} - Cantidad: ${detalle.cantidad}, 
                        Precio: S/. ${detalle.precio}, 
                        Subtotal: S/. ${detalle.cantidad * detalle.precio}
                    </li>
                </c:forEach>
            </ul>
              <form action="${pageContext.request.contextPath}/EliminarPedido.htm" method="post">
    <input type="hidden" name="idpedido" value="${p.idpedido}" />
    <button type="submit" style="margin-top: 10px; background-color: #e74c3c; color: white; border: none; padding: 8px 12px; border-radius: 5px;">
        Eliminar Pedido
    </button>
</form>

        </div>
    </div>
      

</c:forEach>

</body>
</html>
</c:if>



