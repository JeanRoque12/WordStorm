# WordStorm 🌪️

Un juego de palabras inspirado en Wordle, desarrollado en Flutter. Adivina la palabra de 5 letras en 6 intentos máximo.

## 📱 Información del Proyecto

- **Creador:** Jean Roque 23-0812
- **Asignatura:** Desarrollo de Apps Móviles
- **Docente:** Joerlyn Morfe

## 🎮 Cómo Jugar

1. **Objetivo:** Adivina la palabra secreta de 5 letras en máximo 6 intentos
2. **Mecánica:** Cada intento debe ser una palabra válida de 5 letras
3. **Pistas por colores:**
   - 🟩 **Verde:** Letra correcta en la posición correcta
   - 🟨 **Amarillo:** Letra está en la palabra pero en posición incorrecta
   - ⬜ **Gris:** Letra no está en la palabra

## ✨ Características

### Funcionalidades Principales
- **Juego completo tipo Wordle** con validación de palabras
- **Sistema de puntuación** que se mantiene entre partidas
- **Guardado automático** del progreso del juego
- **Interfaz intuitiva** con teclado virtual
- **Validación de palabras** usando diccionario de 1000+ palabras en inglés

### Características Técnicas
- **Gestión de estado** con singleton pattern
- **Persistencia de datos** entre sesiones
- **Arquitectura modular** con separación de componentes
- **Temas personalizables** (claro/oscuro disponibles)
- **Diálogos informativos** y de ayuda

## 🏗️ Estructura del Proyecto

```
lib/
├── main.dart                    # Punto de entrada de la aplicación
├── pages/
│   ├── homePage.dart           # Pantalla principal del menú
│   └── gamePage.dart           # Pantalla del juego
├── components/
│   ├── board.dart              # Tablero de juego
│   ├── keyboard.dart           # Teclado virtual
│   ├── win_dialog.dart         # Diálogo de victoria
│   ├── lose_dialog.dart        # Diálogo de derrota
│   ├── options_dialog.dart     # Menú de opciones
│   ├── help_dialog.dart        # Diálogo de ayuda
│   └── info_dialog.dart        # Información del proyecto
└── data/
    ├── themes.dart             # Temas y estilos del juego
    ├── words.dart              # Diccionario de palabras válidas
    └── game_state.dart         # Gestión del estado del juego
```

## 🔧 Componentes Principales

### GameBoard (`board.dart`)
- Renderiza el tablero de 6x5 casillas
- Maneja los estados visuales de cada casilla
- Utiliza el modelo `SquareModel` para gestionar letra y estado

### GameKeyboard (`keyboard.dart`)
- Teclado QWERTY virtual
- Botones especiales: "GO" para enviar palabra y "⌫" para borrar
- Diseño responsivo con espaciado optimizado

### GameState (`game_state.dart`)
- Singleton que mantiene el estado del juego
- Funcionalidades de guardado y carga
- Gestión de puntuación y progreso

## 🎨 Sistema de Temas

El juego incluye dos temas predefinidos:

### Tema Claro (`lightGameTheme`)
- Fondo claro (#EFEFEF)
- Casillas blancas con bordes negros
- Colores estándar para estados (verde, amarillo, gris)

### Tema Oscuro (`darkGameTheme`)
- Fondo oscuro (#121212)
- Casillas grises oscuras
- Colores adaptados para modo oscuro

## 🚀 Instalación y Ejecución

### Prerequisitos
- Flutter SDK (versión 3.0+)
- Dart SDK
- Android Studio / VS Code
- Dispositivo Android/iOS o emulador

### Pasos de Instalación

1. **Clonar el repositorio:**
```bash
git clone <url-del-repositorio>
cd wordstorm
```

2. **Instalar dependencias:**
```bash
flutter pub get
```

3. **Ejecutar la aplicación:**
```bash
flutter run
```

### Compilación para Producción

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## 🎯 Funcionalidades del Juego

### Menú Principal
- **Nuevo Juego:** Inicia una partida completamente nueva
- **Continuar:** Reanuda la partida guardada (si existe)
- **Puntaje Record:** Muestra el mejor puntaje alcanzado
- **Ayuda:** Explicación de las reglas del juego
- **Información:** Datos del creador y proyecto

### Durante el Juego
- **Menú de opciones:** Accesible mediante el ícono de menú
- **Continuar:** Volver al juego actual
- **Nuevo Juego:** Reiniciar con nueva palabra
- **Ir al menú:** Guardar progreso y volver al menú principal
- **Validación en tiempo real:** Verificación de palabras válidas
- **Retroalimentación visual:** Animaciones y colores para guiar al jugador

## 🔮 Estados del Juego

### SquareStatus (Enum)
- `initial`: Casilla vacía
- `correct`: Letra correcta en posición correcta
- `present`: Letra en la palabra pero mal ubicada
- `absent`: Letra no está en la palabra

### Flujo del Juego
1. **Inicio:** Selección de palabra aleatoria del diccionario
2. **Jugada:** Ingreso de palabra de 5 letras
3. **Validación:** Verificación contra diccionario
4. **Evaluación:** Comparación con palabra objetivo
5. **Resultado:** Victoria (palabra correcta) o derrota (6 intentos agotados)

## 📚 Diccionario

El juego utiliza un diccionario de **1000+ palabras** en inglés de 5 letras, incluyendo:
- Sustantivos comunes
- Adjetivos
- Verbos
- Palabras técnicas y coloquiales

## 🏆 Sistema de Puntuación

- **Incremento:** +1 por cada palabra adivinada correctamente
- **Persistencia:** El puntaje se mantiene entre sesiones
- **Record:** Se muestra el mejor puntaje alcanzado
- **Reset:** Se reinicia al perder una partida

## 🔄 Gestión de Estado

### Singleton Pattern
- `GameState` mantiene el estado global de la aplicación
- Permite guardar y cargar el progreso del juego
- Gestiona la puntuación de manera persistente

### Datos Guardados
- Tablero actual con letras y estados
- Posición actual (fila y columna)
- Palabra objetivo
- Puntuación acumulada
- Palabra parcialmente ingresada

## 🎨 Personalización

### Modificar Temas
Edita el archivo `themes.dart` para personalizar colores:

```dart
const customGameTheme = GameTheme(
  tileColor: Colors.your_color,
  correctColor: Colors.your_color,
  presentColor: Colors.your_color,
  absentColor: Colors.your_color,
  backgroundColor: Colors.your_color,
  letterStyle: TextStyle(/* tu estilo */),
);
```

### Agregar Palabras
Modifica el archivo `words.dart` para expandir el diccionario:

```dart
final List<String> fiveLetterWords = [
  // Agregar nuevas palabras aquí
  "nueva",
  "palabra",
];
```

## 🐛 Resolución de Problemas

### Problemas Comunes

**Error de compilación:**
- Verificar versión de Flutter: `flutter --version`
- Limpiar proyecto: `flutter clean && flutter pub get`

**Problemas de renderizado:**
- Verificar que el dispositivo/emulador esté actualizado
- Reiniciar la aplicación

**Estado no se guarda:**
- Verificar que `GameState` se esté llamando correctamente
- Comprobar que `onSaveBeforeExit` se ejecute antes de salir

## 📄 Licencia

Este proyecto fue desarrollado con fines educativos para la asignatura de Desarrollo de Apps Móviles.

## 🤝 Contribuciones

Al ser un proyecto académico, las contribuciones están limitadas al contexto educativo de la asignatura.

---

*Desarrollado con ❤️ usando Flutter*
