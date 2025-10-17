<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/jsp/panelproducto/menuAdmin.jsp" %>

<c:if test="${sessionScope.usuario != null && sessionScope.usuario.role == 'ADMIN'}">
    <!-- Solo visible para admin -->
</c:if>

<html>
<head>
    <title>Panel de Productos</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            margin: 40px auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 25px 30px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: #fff;
        }

        tr:hover {
            background-color: #f2f2f2;
        }

        .img-container {
            width: 70px;
            height: 70px;
            border-radius: 8px;
            overflow: hidden;
            border: 1px solid #ccc;
            margin: 0 auto;
            background-color: #fafafa;
        }

        .img-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        a.button {
            padding: 6px 12px;
            color: #fff;
            border-radius: 6px;
            text-decoration: none;
            transition: 0.3s;
        }

        a.button:hover {
            opacity: 0.85;
        }

        a.button.add { background-color: #28a745; }
        a.button.edit { background-color: #007bff; }
        a.button.delete { background-color: #dc3545; }

        .acciones {
            display: flex;
            justify-content: center;
            gap: 8px;
        }

        em { color: #888; }
    </style>
</head>

<body>
    <div class="container">
        <h2>Listado de Productos</h2>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Clave</th>
                    <th>Nombre</th>
                    <th>Precio</th>
                    <th>Cantidad</th>
                    <th>Proveedor</th>
                    <th>Imagen</th>
                    <th>Descripción</th>
                    <th>Acciones</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="prod" items="${lista}">
                    <tr>
                        <td>${prod.idprod}</td>
                        <td>${prod.clave}</td>
                        <td>${prod.nombre}</td>
                        <td>S/. ${prod.precio}</td>
                        <td>${prod.cantidad}</td>

                        <!-- ✅ Mostrar proveedor sin tono azul -->
                       <td>
    <c:choose>
        <c:when test="${not empty prod.proveedor_nombre}">
            ${prod.proveedor_nombre}
        </c:when>
        <c:otherwise>
            <em>Sin proveedor</em>
        </c:otherwise>
    </c:choose>
</td>


                        <!-- ✅ Mostrar imagen -->
                        <td>
                            <c:choose>
                                <c:when test="${not empty prod.imagen}">
                                    <div class="img-container">
                                        <c:choose>
                                            <c:when test="${fn:startsWith(prod.imagen, 'http')}">
                                                <img src="${prod.imagen}" alt="Imagen producto">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/imagenes/${prod.imagen}" alt="Imagen producto">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <em>Sin imagen</em>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <!-- ✅ Acciones -->
                        <td class="acciones">
                            <a href="${pageContext.request.contextPath}/editarProducto.htm?idprod=${prod.idprod}" class="button edit">✏️</a>
                            <a href="${pageContext.request.contextPath}/eliminarProducto.htm?idprod=${prod.idprod}" class="button delete"
                               onclick="return confirm('¿Estás seguro de eliminar este producto?');">🗑️</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
