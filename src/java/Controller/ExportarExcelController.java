/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

/**
 *
 * @author BARTOBY
 */
import DAO.ProductoDAO;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class ExportarExcelController {
    @Autowired
    private ProductoDAO productoDAO;
    
    /*OLA, SOY DIRI Y ESTUVE AQUI*/
    @GetMapping("/exportarProductosExcel")
    public void exportarProductosExcel(HttpServletResponse response) {
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment; filename=productos.xls");

        try (Workbook workbook = new HSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Productos");

            /*Crear estilo para encabezado*/
            CellStyle headerStyle = workbook.createCellStyle();
            Font font = workbook.createFont();
            font.setBold(true);
            headerStyle.setFont(font);

            /*Definir columnas*/
            String[] columnas = {"ID", "Clave", "Nombre", "Precio", "Cantidad", "Proveedor"};
            Row header = sheet.createRow(0);
            for (int i = 0; i < columnas.length; i++) {
                Cell cell = header.createCell(i);
                cell.setCellValue(columnas[i]);
                cell.setCellStyle(headerStyle);
            }

            /*Obtener y llenar datos*/
            var lista = productoDAO.listarTodos();
            int rowNum = 1;
            for (var p : lista) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(p.getIdprod());
                row.createCell(1).setCellValue(p.getClave());
                row.createCell(2).setCellValue(p.getNombre());
                row.createCell(3).setCellValue(p.getPrecio());
                row.createCell(4).setCellValue(p.getCantidad());
                row.createCell(5).setCellValue(p.getProveedorNombre());
            }

            /*Ajustar tamaño de columnas automáticamente*/
            for (int i = 0; i < columnas.length; i++) {
                sheet.autoSizeColumn(i);
            }

            /*Escribir en la respuesta*/
            workbook.write(response.getOutputStream());

        } catch (IOException e) {
            e.printStackTrace();
            /* Aquí podrías registrar el error con un logger si lo usas*/
        }
    }
}
