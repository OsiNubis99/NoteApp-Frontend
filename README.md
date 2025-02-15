[![Flutter CI](https://github.com/OsiNubis99/NoteApp-Frontend/actions/workflows/flutter-workflow.yml/badge.svg?branch=main)](https://github.com/OsiNubis99/NoteApp-Frontend/actions/workflows/flutter-workflow.yml)
<p align="center">
  <img src="./assets/my_notes_app.png" width="320" alt="NoteApp" />
</p>

## _NoteApp-Mobile_

Applicación mobile desarrollada por Clean Coders Naranja, utilizando Flutter. Complementada por el [Backend Nestjs](https://github.com/omarlopezoficial/NoteApp-Backend/)

## _Figma_
https://www.figma.com/file/h2JDWXfSIadBIQriFZUYZq/NotasApp?type=design&node-id=0%3A1&mode=design&t=2sdqoqmTvUZvoI9L-1

## Instalación
```bash
# Clean the dependencies
$ flutter clean
```

```bash
# Get the dependencies
$ flutter pub get
```

## Generar un APK
 Estos comandos compialran el codigo y generaran un APK local o tambien se puede obtener el uno autogenerado por las [GitHub Actions](https://github.com/omarlopezoficial/NoteApp-Frontend/actions)
 
```bash
# Analyze code before generate APK
$ flutter analyze --no-fatal-infos .
```

```bash
# Generate APK
$ flutter build apk
```

## Librerías y códigos externos usados:

- [Flutter](https://flutter.dev/)
- [dio](https://pub.dev/packages/dio)
- [quill html editor](https://pub.dev/packages/quill_html_editor)
- [geolocator](https://pub.dev/packages/geolocator)
- [geocoding](https://pub.dev/packages/geocoding)
- [speech to text](https://pub.dev/packages/speech_to_text)
- [image to text](https://pub.dev/packages/google_mlkit_text_recognition) 
- [image picker](https://pub.dev/packages/image_picker) 
- [image cropper](https://pub.dev/packages/image_cropper) 
- [alert](https://pub.dev/packages/awesome_snackbar_content)
- [form payment](https://pub.dev/packages/mask_text_input_formatter)
- [random](https://pub.dev/packages/random_string)
