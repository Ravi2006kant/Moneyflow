
import 'package:flutter/material.dart';
import 'package:moneyflow/database/dbHelper.dart';

class TransactionDetail extends StatefulWidget {
  const TransactionDetail({
    super.key,
    required this.newid,
    required this.amount,
    this.note,
    this.category,
    this.date,
  });

  final String amount;
  final String? note;
  final int newid;
  final String? category;
  final DateTime? date;

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  String get formattedDate {
    final date = widget.date;
    if (date == null) return 'Date not available';

    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];

    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }

  Widget detailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final note = widget.note?.trim();
    final category = widget.category?.trim();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Amount card
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 38,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Transaction Amount',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: .bold,
                        fontSize: 20
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹ ${widget.amount}',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface.withValues(
                          alpha: 0.7,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Transaction ID: ${widget.newid}',
                        style: theme.textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Transaction Information',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Card(
                elevation: 0,
                color: theme.colorScheme.surfaceContainerLow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      detailRow(
                        icon: Icons.notes_rounded,
                        title: 'Note',
                        value: note == null || note.isEmpty
                            ? 'No note added'
                            : note,
                      ),
                      Divider(
                        height: 1,
                        color: theme.colorScheme.outlineVariant,
                      ),
                      detailRow(
                        icon: Icons.category_outlined,
                        title: 'Category',
                        value: category == null || category.isEmpty
                            ? 'Uncategorized'
                            : category,
                      ),
                      Divider(
                        height: 1,
                        color: theme.colorScheme.outlineVariant,
                      ),
                      detailRow(
                        icon: Icons.calendar_month_outlined,
                        title: 'Date',
                        value: formattedDate,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Connect your edit screen here.
                      },
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Edit'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (dialogContext) => AlertDialog(
                            title: const Text('Delete transaction?'),
                            content: const Text(
                              'This transaction will be permanently deleted.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(dialogContext, false),
                                child: const Text('Cancel'),
                              ),
                              FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () =>
                                    Navigator.pop(dialogContext, true),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );

                        if (confirm != true || !context.mounted) return;

                        await Dbhelper.getInstance().deleteNote(
                          id: widget.newid,
                        );

                        if (context.mounted) {
                          Navigator.pop(context, true);
                        }
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Delete'),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
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
