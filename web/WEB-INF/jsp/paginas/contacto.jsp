<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/jsp/menu.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Contacto</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- CSS personalizado -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/paginas.css">

    <style>
        .contact-container {
            background: #fff;
            border-radius: 10px;
            padding: 30px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

    <div class="container d-flex justify-content-center align-items-center flex-grow-1">
        <div class="contact-container">
            <h2 class="text-center mb-4">Contacto</h2>

            <!-- Mensaje de éxito -->
            <c:if test="${not empty mensajeExito}">
                <div class="alert alert-success text-center">${mensajeExito}</div>
            </c:if>

            <!-- Formulario visible siempre -->
            <form action="
                <c:choose>
                    <c:when test='${not empty sessionScope.usuario}'>
                        ${pageContext.request.contextPath}/guardarContacto.htm
                    </c:when>
                    <c:otherwise>
                        ${pageContext.request.contextPath}/login.htm
                    </c:otherwise>
                </c:choose>
            " method="post">
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Tu nombre" required>
                </div>
                <div class="mb-3">
                    <label for="correo" class="form-label">Correo electrónico</label>
                    <input type="email" class="form-control" id="correo" name="correo" placeholder="nombre@ejemplo.com" required>
                </div>
                <div class="mb-3">
                    <label for="mensaje" class="form-label">Mensaje</label>
                    <textarea class="form-control" id="mensaje" name="mensaje" rows="5" placeholder="Escribe tu mensaje aquí..." required></textarea>
                </div>

                <!-- Botón cambia según sesión -->
                <c:choose>
                    <c:when test="${not empty sessionScope.usuario}">
                        <button type="submit" class="btn btn-primary w-100">Enviar</button>
                    </c:when>
                    <c:otherwise>
                        <button type="submit" class="btn btn-warning w-100">Iniciar sesión para enviar</button>
                    </c:otherwise>
                </c:choose>
            </form>

        </div>
    </div>

    <!-- Footer -->
    <footer class="footer bg-light py-3 mt-auto">
        <div class="container text-center">
            © 2025 Mi Perú. Todos los derechos reservados.
        </div>
    </footer>

</body>
</html>
