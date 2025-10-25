import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/products_container.dart';

/// Экран добавления/редактирования товара.
/// Вариант B: если экран открыт как ВКЛАДКА в HomeScreen,
/// по завершении сохранения вызывает [onSavedInTab] для переключения вкладки.
class ProductFormScreen extends StatefulWidget {
  final Product? editing;
  final VoidCallback? onSavedInTab; // ✅ колбэк для варианта B

  const ProductFormScreen({
    super.key,
    this.editing,
    this.onSavedInTab,
  });

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _brandCtrl = TextEditingController();
  final _volumeCtrl = TextEditingController();
  final _expCtrl = TextEditingController();
  final _imageUrlCtrl = TextEditingController();

  final _categories = const ['Уходовая', 'Декоративная', 'Парфюмерия'];
  String _category = 'Уходовая';
  double _rating = 3;

  @override
  void initState() {
    super.initState();
    final e = widget.editing;
    if (e != null) {
      _nameCtrl.text = e.name;
      _brandCtrl.text = e.brand;
      _volumeCtrl.text = e.volume;
      _expCtrl.text = e.expirationDate;
      _category = e.category;
      _rating = e.rating;
      _imageUrlCtrl.text = e.imageUrl ?? '';
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _brandCtrl.dispose();
    _volumeCtrl.dispose();
    _expCtrl.dispose();
    _imageUrlCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final container = ProductsContainer.of(context);
    final imageUrl = _imageUrlCtrl.text.trim().isEmpty
        ? null
        : _imageUrlCtrl.text.trim();

    if (widget.editing == null) {
      container.addProduct(Product(
        id: 0, // присвоится автоматически
        name: _nameCtrl.text.trim(),
        brand: _brandCtrl.text.trim(),
        category: _category,
        volume: _volumeCtrl.text.trim(),
        expirationDate: _expCtrl.text.trim(),
        rating: _rating,
        isFavorite: false,
        imageUrl: imageUrl,
      ));
    } else {
      container.updateProduct(widget.editing!.copyWith(
        name: _nameCtrl.text.trim(),
        brand: _brandCtrl.text.trim(),
        category: _category,
        volume: _volumeCtrl.text.trim(),
        expirationDate: _expCtrl.text.trim(),
        rating: _rating,
        imageUrl: imageUrl,
      ));
    }

    // ✅ Вариант B:
    // если экран открыт через push -> закрываем,
    // если это вкладка -> просим HomeScreen переключить вкладку и остаёмся.
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      widget.onSavedInTab?.call(); // переключить вкладку в HomeScreen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Продукт сохранён')),
      );
      // Дополнительно можно очистить форму:
      _nameCtrl.clear();
      _brandCtrl.clear();
      _volumeCtrl.clear();
      _expCtrl.clear();
      _imageUrlCtrl.clear();
      setState(() {
        _category = 'Уходовая';
        _rating = 3;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.editing != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Редактирование' : 'Добавить продукт'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Название'),
                validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Введите название' : null,
              ),
              TextFormField(
                controller: _brandCtrl,
                decoration: const InputDecoration(labelText: 'Бренд'),
                validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Введите бренд' : null,
              ),
              DropdownButtonFormField<String>(
                value: _category,
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v!),
                decoration: const InputDecoration(labelText: 'Категория'),
              ),
              TextFormField(
                controller: _volumeCtrl,
                decoration:
                const InputDecoration(labelText: 'Объём (напр., 50 мл)'),
                validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Укажите объём' : null,
              ),
              TextFormField(
                controller: _expCtrl,
                decoration:
                const InputDecoration(labelText: 'Срок годности (ММ.ГГГГ)'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Укажите срок годности'
                    : null,
              ),
              TextFormField(
                controller: _imageUrlCtrl,
                decoration: const InputDecoration(
                  labelText: 'URL изображения (опционально)',
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Рейтинг:'),
                  Expanded(
                    child: Slider(
                      value: _rating,
                      min: 1,
                      max: 5,
                      divisions: 8,
                      label: _rating.toStringAsFixed(1),
                      onChanged: (v) => setState(() => _rating = v),
                    ),
                  ),
                  Text('★ ${_rating.toStringAsFixed(1)}'),
                ],
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
