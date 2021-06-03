import 'package:expenses/util/brasil_util.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();

  final _dateController = TextEditingController(text: BrasilUtil.formatShortDate(DateTime.now()));

  void _submitForm() {
    var title = _titleController.text;
    var value = double.tryParse(_valueController.text) ?? 0.0;
    var date = _dateController.text;

    var formIsValid = !(title.isEmpty || value <= 0 || date.isEmpty);

    if (formIsValid) {
      widget.onSubmit(title, value, BrasilUtil.toDateTimeFromShortDate(date));
    }
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: BrasilUtil.toDateTimeFromShortDate(_dateController.text) ??
          DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        _dateController.text = BrasilUtil.formatShortDate(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Valor (R\$)',
                  prefixText: 'R\$ ',
                ),
              ),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Data',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: _showDatePicker,
                controller: _dateController,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('NOVA TRANSAÇÃO'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
