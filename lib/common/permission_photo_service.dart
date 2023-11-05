import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  final BuildContext context;

  PermissionService(this.context);

  Future<bool> requestPhotoPermission() async {
    var status = await Permission.photos.status;
    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      _showSettingDialog();
      return false;
    }

    status = await Permission.photos.request();
    if (status.isGranted) {
      return true;
    } else {
      _showDeniedMessage();
      return false;
    }
  }

  void _showSettingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Permissão Necessária'),
        content: Text(
            'Precisamos da sua permissão para acessar a galeria. Por favor, habilite a permissão de fotos nas configurações do seu dispositivo.'),
        actions: <Widget>[
          TextButton(
            child: Text('Configurações'),
            onPressed: () {
              openAppSettings();
            },
          ),
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _showDeniedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Permissão para acessar a galeria foi negada.'),
      ),
    );
  }
}
