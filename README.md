# Todo List Technical Test

Una aplicación Flutter para gestionar tareas y elementos pendientes, construida con prácticas modernas de Flutter y gestión de estado.

## 🚀 Comenzando

### Prerrequisitos

- Flutter SDK (versión 3.27.0)
- Dart SDK (versión 3.8.1 o superior)
- Java Development Kit (JDK 21)
- Android Studio / VS Code con extensiones de Flutter
- Git

### Instalación

1. Clona el repositorio:

```bash
git clone https://github.com/yourusername/todo_list_technical_test.git
cd todo_list_technical_test
```

2. Instala las dependencias:

```bash
flutter pub get
```

3. Ejecuta la aplicación:

```bash
flutter run
```

## 📦 Dependencias

### Dependencias Principales

- **flutter_riverpod** (^2.6.1) - Gestión de estado
- **formz** (^0.8.0) - Validación de formularios
- **freezed_annotation** (^2.1.0) - Generación de código para modelos inmutables
- **google_fonts** (^6.2.1) - Fuentes personalizadas
- **hive** (^2.2.3) - Almacenamiento local
- **hive_flutter** (^1.1.0) - Integración de Hive con Flutter
- **path_provider** (^2.1.2) - Acceso al sistema de archivos
- **riverpod_annotation** (^2.6.1) - Generación de código para Riverpod
- **uuid** (^4.3.3) - Generación de IDs únicos

### Dependencias de Desarrollo

- **build_runner** (^2.4.15) - Generación de código
- **freezed** (^2.1.0) - Generación de código para modelos inmutables
- **hive_generator** (^2.0.1) - Generación de código para Hive
- **riverpod_generator** (^2.3.9) - Generación de código para Riverpod
- **very_good_analysis** (^8.0.0) - Reglas de linting

## 🏗️ Arquitectura

Este proyecto implementa una versión simplificada de arquitectura limpia, adaptada a las necesidades específicas de una aplicación de lista de tareas. Por la naturaleza del proyecto y su caso de uso, se ha optado por una estructura más directa que mantiene los principios de separación de responsabilidades pero sin la complejidad de una arquitectura completa.

### Estructura Actual

- **Presentación**:

  - Widgets y pantallas de la aplicación
  - Providers de Riverpod para la gestión de estado
  - Formularios y validaciones

- **Datos**:
  - Almacenamiento local con Hive
  - Modelos de datos

### Posibles Mejoras

En un entorno de producción o en un proyecto más robusto, la arquitectura podría expandirse para incluir:

- **Capa de Dominio**:

  - Casos de uso específicos
  - Entidades de negocio
  - Interfaces de repositorio

- **Capa de Infraestructura**:

  - Implementaciones concretas de repositorios
  - Servicios externos
  - Configuraciones de red

- **Capa de Aplicación**:
  - Coordinadores
  - Mapeadores
  - Servicios de aplicación

El proyecto actual utiliza:

- **Riverpod** para la gestión de estado
- **Hive** para almacenamiento local
- **Freezed** para modelos inmutables
- **Formz** para validación de formularios

## 🔧 Desarrollo

Para generar los archivos de código necesarios, ejecuta:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Para ejecutar los tests de la aplicación, puedes usar:

```bash
make test
```

O directamente con Flutter:

```bash
flutter test
```

### Configuración del Entorno

1. Asegúrate de tener Java 21 instalado y configurado en tu sistema:

   ```bash
   java -version
   ```

2. Configura la variable de entorno JAVA_HOME apuntando a tu instalación de Java 21:

   ```bash
   export JAVA_HOME=/path/to/java21
   ```

3. Para desarrollo en Android, asegúrate de que tu Android SDK esté configurado correctamente en Android Studio.

## 📱 Características

- Crear, leer, actualizar y eliminar tareas
- Persistencia de datos en almacenamiento local
- Interfaz de usuario limpia y moderna
- Validación de formularios
- Gestión de estado con Riverpod
