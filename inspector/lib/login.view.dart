import 'package:flutter/material.dart';
import 'package:inspector/home.view.dart';
import 'package:inspector/widgets/background.widget.dart';
import 'package:inspector/widgets/numberButton.widget.dart';
import 'package:inspector/widgets/textFieldDecoration.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget 
{
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> 
{
  String _password = '';
  String _correctPassword = '';
  bool _setPassword = false;
  final String _configText = 'Configure uma senha e clique duas vezes no botão de entrada para confirmá-la';


  final TextEditingController _controller = TextEditingController();
  var selectedIndex = 0;

   @override
  void initState()
  {
    super.initState();
    _loadPassword(); 
  }

  void _loadPassword() async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() 
    {
      _correctPassword = prefs.getString('correctPassword') ?? '';
      _setPassword = _correctPassword.isNotEmpty;
    });
  }

  void _savePassword(String password) async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('correctPassword', password);
  }

  void _addNumber (String number) 
  {
    setState (() 
    {
      _password += number;
      _controller.text = _password;
    });
  }

  void _clean() 
  {
    setState(() 
    {
      _password = '';
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: const Color.fromRGBO(255, 218, 133, 1.0),
      body: Stack
      (
        children: 
        [
          const Background(),

          SizedBox
          (
            width: 10,
            height: 10,
            child: ElevatedButton
            (
              onPressed: ()
              {
                _correctPassword = '';
                _setPassword = false;
              },
              style: 
              ElevatedButton.styleFrom
              (
                backgroundColor: const Color.fromRGBO(140, 82, 255, 1.0),
              ), 
              child: null
           ),
          ),
          Center
          (
            child: Column
            (
              mainAxisAlignment: MainAxisAlignment.end,
              children: 
              [
                SizedBox
                (
                  width: 400,
                  child:
                  TextField
                  (
                    controller: _controller,
                    obscureText: true,
                    decoration: getTextFieldDecoration('Senha')
                  ),
                ),

                if(_correctPassword == '')
                  Text(_configText),

                const SizedBox
                (
                  height: 50,
                ),

                  Container
                  (
                    alignment: Alignment.bottomCenter,
                    
                    child: SizedBox
                    (
                      height: 375,
                      width: 250,
                      child: Column
                      (
                        children: 
                        [
                          Row
                          (
                            children: 
                            [
                              NumberButton( number: '1', onPressed: () => _addNumber('1')),
                      
                              const SizedBox(width: 8),
                              
                              NumberButton( number: '2', onPressed: () => _addNumber('2')),

                              const SizedBox(width: 8),
                      
                              NumberButton( number: '3', onPressed: () => _addNumber('3')),
                            ],
                          ),
                      
                          const SizedBox(height: 8),

                          Row
                          (
                            children: 
                            [
                             NumberButton( number: '4', onPressed: () => _addNumber('4')),
                      
                              const SizedBox(width: 8),

                              NumberButton( number: '5', onPressed: () => _addNumber('5')),

                              const SizedBox(width: 8),

                              NumberButton( number: '6', onPressed: () => _addNumber('6')),
                            ],
                          ),
                      
                          const SizedBox(height: 8),

                          Row
                          (
                            children: 
                            [
                             NumberButton( number: '7', onPressed: () => _addNumber('7')),
                      
                              const SizedBox(width: 8),
                      
                              NumberButton( number: '8', onPressed: () => _addNumber('8')),
                      
                              const SizedBox(width: 8),
                      
                              NumberButton( number: '9', onPressed: () => _addNumber('9')),
                            ],
                          ),
                      
                          const SizedBox(height: 8),
                      
                          Row
                          (
                            children: 
                            [
                              Expanded
                              (
                                child: SizedBox
                                (
                                  height: 80,
                                  child: IconButton
                                  (
                                    icon: const Icon(Icons.clear_rounded),
                                    color: const Color.fromRGBO(140, 82, 255, 1.0),
                                    iconSize: 40,
                                    onPressed: ()
                                    {
                                      _clean();
                                    },
                                  ),
                                ),
                              ),

                              NumberButton( number: '0', onPressed: () => _addNumber('0')),

                              const SizedBox(width: 8),
                      
                              Expanded
                              (
                                child: SizedBox
                                (
                                  height: 80,
                                  child: IconButton
                                  (
                                    icon: const Icon(Icons.play_arrow_rounded),
                                    color: const Color.fromRGBO(255, 130, 0, 1.0),
                                    iconSize: 50,
                                    onPressed: ()
                                    {
                                      if (_setPassword == false)
                                      {
                                        _correctPassword = _password;
                                        _savePassword(_correctPassword);
                                        _password = '';
                                        _setPassword = true;
                                      }
                                      else
                                      {
                                        if (_password == _correctPassword)
                                        {
                                          Navigator.push
                                          (
                                            context,
                                            MaterialPageRoute(builder: (context) => const HomeView())
                                          );
                                        }
                                        else
                                        {
                                          _clean();
                                        }
                                      }
                                    }                                     
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
      )
    );
  }
}