<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/menu.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Servicios al Cliente - DIRI VERY</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to bottom right, #f8f9fa, #e9ecef);
            padding-top: 70px;
        }
        h2 {
            font-weight: bold;
            color: #0d6efd;
        }
        .card-custom {
            background: #ffffff;
            border: none;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            margin-bottom: 25px;
            transition: transform 0.2s ease;
        }
        .card-custom:hover {
            transform: translateY(-5px);
        }
        .icon-box {
            font-size: 32px;
            color: #0d6efd;
            margin-bottom: 10px;
        }
        .section-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #343a40;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-5"><i class="fa-solid fa-bell-concierge"></i> Servicios al Cliente - DIRI VERY</h2>

    <div class="row">
        <div class="col-md-6">
            <div class="card-custom text-center">
                <div class="icon-box"><i class="fa-solid fa-truck-fast"></i></div>
                <h4 class="section-title">Seguimiento de Entregas</h4>
                <p>Rastrea en tiempo real tu pedido dentro de Lima. Con nuestro sistema sabrás exactamente dónde está tu entrega desde la fábrica hasta tu tienda.</p>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card-custom text-center">
                <div class="icon-box"><i class="fa-solid fa-right-left"></i></div>
                <h4 class="section-title">Cambios y Reemplazos</h4>
                <p>Si tu pedido presenta algún inconveniente, gestionamos cambios rápidos en menos de 24 horas dentro de Lima Metropolitana.</p>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card-custom text-center">
                <div class="icon-box"><i class="fa-solid fa-phone-volume"></i></div>
                <h4 class="section-title">Atención Directa</h4>
                <ul class="list-unstyled">
                    <li><i class="fa-solid fa-phone"></i> Teléfono: (01) 765-4321</li>
                    <li><i class="fa-brands fa-whatsapp"></i> WhatsApp: +51 999 888 777</li>
                    <li><i class="fa-solid fa-envelope"></i> Correo: soporte@dirivery.pe</li>
                </ul>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card-custom text-center">
                <div class="icon-box"><i class="fa-solid fa-circle-question"></i></div>
                <h4 class="section-title">Preguntas Frecuentes (FAQ)</h4>
                <p>
                    <strong>¿Cuánto tarda el envío?</strong> En Lima, entre 2 y 6 horas según la zona.<br>
                    <strong>¿Aceptan pagos contra entrega?</strong> Sí, en toda Lima Metropolitana.<br>
                    <strong>¿Puedo cancelar un pedido?</strong> Sí, si aún no ha salido de fábrica.
                </p>
            </div>
        </div>

        <div class="col-md-12">
            <div class="card-custom text-center">
                <div class="icon-box"><i class="fa-regular fa-clock"></i></div>
                <h4 class="section-title">Horario de Atención</h4>
                <p>Atendemos de <strong>lunes a sábado</strong>, de <strong>8:00 a.m. a 8:00 p.m.</strong><br>
                   Nuestro objetivo es que tus pedidos lleguen siempre rápido y seguros en Lima.</p>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer bg-light py-3 mt-5">
    <div class="container text-center">
      © 2025 DIRI VERY. Todos los derechos reservados.
    </div>
</footer>

</body>
</html>
