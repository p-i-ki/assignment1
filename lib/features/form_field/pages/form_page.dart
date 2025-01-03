import 'package:assignment_app/core/models/user.dart';
import 'package:assignment_app/core/widgets/custom_app_bar.dart';
import 'package:assignment_app/core/widgets/custom_form_field.dart';
import 'package:assignment_app/core/widgets/custom_out_button.dart';
import 'package:assignment_app/features/form_field/bloc/bloc/form_page_bloc.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedGender;
  String? _country = "";
  String? _state = "";
  String? _city = "";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _selectedGender!.isNotEmpty &&
        _country!.isNotEmpty &&
        _state!.isNotEmpty &&
        _city!.isNotEmpty) {
      // _formKey.currentState!.save();
      User user = User(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        gender: _selectedGender!,
        country: _country!,
        state: _state!,
        city: _city!,
      );
      context.read<FormPageBloc>().add(FormSubmitEvent(user: user));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(text: "Form Page"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Field
                CustomTextField(
                  hintText: "Name",
                  controller: _nameController,
                  validatorFun: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return "";
                  },
                ),

                const SizedBox(height: 16),

                // Email Field

                CustomTextField(
                  controller: _emailController,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validatorFun: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return "";
                  },
                ),
                const SizedBox(height: 16),

                // Phone Field
                CustomTextField(
                  controller: _phoneController,
                  hintText: "Phone",
                  keyboardType: TextInputType.number,
                  validatorFun: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.length != 10) {
                      return 'Phone number must be 10 digits';
                    }
                    return "";
                  },
                ),
                const SizedBox(height: 16),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  padding: EdgeInsets.only(right: 16),
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    //   width: MediaQuery.of(context).size.width * 0.9,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide:
                          BorderSide(color: Colors.redAccent, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide:
                          BorderSide(color: Colors.redAccent, width: 0.5),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  value: _selectedGender,
                  items: ['Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select your gender' : null,
                ),
                const SizedBox(height: 16),

                CSCPicker(
                  layout: Layout.vertical,
                  onCountryChanged: (value) {
                    setState(() {
                      _country = value;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      _state = value;
                    });
                  },
                  onCityChanged: (value) {
                    _city = value;
                  },
                  countryDropdownLabel: _country ?? "Country",
                  stateDropdownLabel: _state ?? "State",
                  cityDropdownLabel: "City",
                ),

                const SizedBox(height: 40),

                // Submit Button
                Center(
                  child: CustomOutBtn(
                    onTap: _submitForm,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 60,
                    color: Colors.white,
                    color2: Colors.blueAccent,
                    text: "Submit",
                  ),
                ),
                // Center(
                //   child: ElevatedButton(
                //     onPressed: _submitForm,
                //     child: const Text('Submit'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
