import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onFillForm;

  const TransactionForm({super.key, required this.onFillForm});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime? _selectedDate;

  _submitForm() {
    String title = titleController.text;
    double value = double.tryParse(valueController.text) ?? 0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) return;

    widget.onFillForm(title, value, _selectedDate!);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        if (value == null) return;

        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 10,
        left: 5,
        right: 5,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Título da Transação'),
                onSubmitted: (_) => _submitForm(),
                textCapitalization: TextCapitalization.words,
              ),
              TextField(
                controller: valueController,
                decoration: InputDecoration(labelText: 'Valor (R\$)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Nenhuma data selecionada'
                        : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text('Selecionar Data'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateColor.fromMap({
                        WidgetState.pressed: Colors.blue[800] ?? Colors.blue,
                        WidgetState.any: Theme.of(context).primaryColor,
                      }),
                    ),
                    child: Text(
                      'Nova Transação',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
