

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/cep_model.dart';
import '../controllers/cep_controller.dart';
import '../controllers/user_controller.dart';
import '../widgets/custom_alert.dart';
import '../widgets/custom_buttom.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/custom_textformfield.dart';

class CepView extends StatefulWidget {
  const CepView(this.cep);
  final CepModel? cep;

  @override
  State<CepView> createState() => _CepViewState();
}

class _CepViewState extends State<CepView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController cep = TextEditingController();
  final TextEditingController logradouro = TextEditingController();
  final TextEditingController complemento = TextEditingController();
  final TextEditingController bairro = TextEditingController();
  final TextEditingController localidade = TextEditingController();
  final TextEditingController uf = TextEditingController();
  final TextEditingController ibge = TextEditingController();
  final TextEditingController gia = TextEditingController();
  final TextEditingController ddd = TextEditingController();
  final TextEditingController siafi = TextEditingController();

  @override
  void initState() {
    if(widget.cep != null){
      _loadCepForm(widget.cep!);
    }
    super.initState();
  }

  _loadCepForm(CepModel? _cep){
    cep.text = _cep?.cep ?? cep.text;
    logradouro.text = _cep?.logradouro ?? '';
    complemento.text = _cep?.complemento ?? '';
    bairro.text = _cep?.bairro ?? '';
    localidade.text = _cep?.localidade ?? '';
    uf.text = _cep?.uf ?? '';
    ibge.text = _cep?.ibge ?? '';
    gia.text = _cep?.gia ?? '';
    ddd.text = _cep?.ddd ?? '';
    siafi.text = _cep?.siafi ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(title: Text('Dados do Cep'),),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Center(child: Text('Digite seu cep para consultar o endereço')),
              SizedBox(height: 10,),
              CustomTextFormField.custom(
                  controller: cep, title: 'CEP', isNext: true, type: FormType.cep,
                  onFieldSubmitted: (v) async {
                    CustomAlert.load(context);
                    final result = await context.read<CepController>().getCep(v);
                    if(result != null) {
                      setState(() {
                        _loadCepForm(result);
                      });
                    }
                    Navigator.pop(context);
                  }
              ),
              SizedBox(height: 10,),
              CustomTextFormField.custom(
                  controller: logradouro, title: 'Endereço', isNext: true, enabled: cep.text.isNotEmpty,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextFormField.custom(controller: complemento, enabled: cep.text.isNotEmpty,
                        title: 'Complemento', isNext: true, validator: (v){ }
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: CustomTextFormField.custom(controller: bairro,
                        title: 'Bairro', isNext: true, enabled: cep.text.isNotEmpty)
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextFormField.custom(controller: localidade,
                        title: 'Cidade', enabled: cep.text.isNotEmpty, isNext: true),
                  ),
                  const SizedBox(width: 10,),

                  Expanded(
                    child: CustomTextFormField.custom(controller: uf, title: 'UF',
                        enabled: cep.text.isNotEmpty, isNext: true),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextFormField.custom(controller: ibge, title: 'IBGE'
                        , enabled: cep.text.isNotEmpty,
                        keyboardType: TextInputType.number, isNext: true, validator: (v){ }),
                  ),
                  const SizedBox(width: 10,),

                  Expanded(
                    child: CustomTextFormField.custom(controller: gia, title: 'GIA'
                        , enabled: cep.text.isNotEmpty,
                        keyboardType: TextInputType.number, isNext: true, validator: (v){ }),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextFormField.custom(controller: ddd, title: 'DDD'
                        , enabled: cep.text.isNotEmpty,
                        keyboardType: TextInputType.number, isNext: true, validator: (v){ }),
                  ),
                  const SizedBox(width: 10,),

                  Expanded(
                    child: CustomTextFormField.custom(controller: siafi, validator: (v){ },
                        keyboardType: TextInputType.number, enabled: cep.text.isNotEmpty,title: 'SIAFI'),
                  ),
                ],
              ),
            ],
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomButtom.custom(
            expand: true,
            height: 32,
            radius: 10,
            title: 'SALVAR',
            onPressed: () async {
              if(_formKey.currentState!.validate()){
                CepModel _model = CepModel();
                if(widget.cep != null){
                  _model = widget.cep!;
                }else{
                  _model.idUser = context.read<UserController>().user?.usrId;
                }
                _model.cep = cep.text;
                _model.logradouro = logradouro.text;
                _model.complemento = complemento.text;
                _model.bairro = bairro.text;
                _model.localidade = localidade.text;
                _model.uf = uf.text;
                _model.ibge = ibge.text;
                _model.gia = gia.text;
                _model.ddd = ddd.text;
                _model.siafi = siafi.text;

                await context.read<CepController>().insertOrUpdateCep(_model, widget.cep != null).then(
                  (value) {
                    if(value > 0){
                      CustomSnackbar.sucess(text: 'Cep ${widget.cep != null ? 'atualizado' : 'cadastrado'} com sucesso!', context: context);
                      Navigator.pop(context);
                    }else{
                      CustomSnackbar.error(text: 'Não foi cadastrar o cep, verifique os dados e tente novamente!', context: context);
                    }
                  }).catchError((onError){
                    CustomSnackbar.error(text: 'Não foi cadastrar o cep, verifique os dados e tente novamente!', context: context);
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
