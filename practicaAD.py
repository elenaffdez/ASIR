#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import xml.etree.ElementTree as ET

# Nombre del archivo XML de entrada y del archivo de salida
archivo_xml = "empresa.xml"
archivo_salida = "salida.txt"

try:
    # Parsear el archivo XML
    miXML = ET.parse(archivo_xml)
    listaventas = miXML.getroot()  # Obtengo el nodo raíz
    
    # Extraemos todas las etiquetas únicas del XML
    etiquetas = sorted(set(elemento.tag for elemento in listaventas.iter()))
    
    # Mostrar etiquetas en columna con formato bonito
    print("\n=== Etiquetas encontradas en el XML ===")
    for etiqueta in etiquetas:
        print(f"{etiqueta}")
    
    # Guardar etiquetas en el archivo de salida
    with open(archivo_salida, "w", encoding="utf-8") as salida:
        salida.write("\n".join(etiquetas) + "\n")
    
    print("\n=== Información detallada de los elementos ===")
    for elemento in listaventas:
        print(f"Elemento: {elemento.tag}")
        
    print("\n=== Detalles de Ventas ===")
    for venta in listaventas.iter('venta'):
        factura = venta.find('codigofactura')
        if factura is not None:
            print(f"Factura: {factura.text}")
            
            # Buscar y mostrar importes asociados
            importes = venta.findall("importe")
            for importe in importes:
                print(f"  -> Importe: {importe.text}")

    # Modificar un elemento del XML como ejemplo de gestión
    print("\n=== Actualización de Salarios ===")
    for empleado in listaventas.iter('empleado'):
        sueldo = empleado.find('salario')
        if sueldo is not None:
            nuevo_sueldo = str(float(sueldo.text) * 1.05)  # Incremento del 5%
            sueldo.text = nuevo_sueldo
            print(f"Empleado {empleado.attrib.get('id', 'desconocido')}: Nuevo salario: {nuevo_sueldo}")
    
    # Guardar cambios en un nuevo archivo XML
    nuevo_archivo_xml = "empresa_modificado.xml"
    miXML.write(nuevo_archivo_xml, xml_declaration=True)
    print(f"\nArchivo modificado guardado como: {nuevo_archivo_xml}")
    
    print(f"\nDatos extraídos y guardados en {archivo_salida}")

except FileNotFoundError:
    print(f"Error: No se encontró el archivo {archivo_xml}")
except ET.ParseError:
    print(f"Error: El archivo {archivo_xml} no es un XML válido")
except Exception as e:
    print(f"Ocurrió un error inesperado: {e}")
