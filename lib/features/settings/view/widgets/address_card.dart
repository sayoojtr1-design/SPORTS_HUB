import 'package:flutter/material.dart';


import '../../model/address_model.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  final Widget? trailing;
  final VoidCallback? onTap;

  const AddressCard({
    super.key,
    required this.address,
    this.onEdit,
    this.onDelete,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Name & Actions / Radio Button
              Row(
                children: [

                  Expanded(
                    child: Text(
                      address.name ?? "",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  if (trailing != null)
                    trailing!
                  else ...[
                    IconButton(
                      onPressed: onEdit,
                      icon: const Icon(
                        Icons.edit_outlined,
                      ),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.delete_outline,
                      ),
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 8),

              /// Phone
              Row(
                children: [
                  const Icon(
                    Icons.phone_outlined,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      address.phone ?? "",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// Address
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "${address.house}, "
                          "${address.area}, "
                          "${address.city}, "
                          "${address.state} - "
                          "${address.pincode}",
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