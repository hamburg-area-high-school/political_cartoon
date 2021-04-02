import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/l10n/l10n.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class DailyCartoonPage extends StatelessWidget {
  const DailyCartoonPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DailyCartoonBloc(
          dailyCartoonRepository: FirebasePoliticalCartoonRepository())
        ..add(LoadDailyCartoon()),
      child: DailyCartoonView(),
    );
  }
}

class DailyCartoonView extends StatefulWidget {
  @override
  _DailyCartoonViewState createState() => _DailyCartoonViewState();
}

class _DailyCartoonViewState extends State<DailyCartoonView> {
  late Stream<PoliticalCartoon> politicalCartoon;

  @override
  void initState() {
    var politicalCartoonRepo = FirebasePoliticalCartoonRepository();
    politicalCartoon = politicalCartoonRepo.getLatestPoliticalCartoon();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: PoliticalCartoonCardLoader(),
        ),
      ),
    );
  }
}

class PoliticalCartoonCardLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<DailyCartoonBloc, DailyCartoonState>(
        builder: (context, state) {
      if (state is DailyCartoonInProgress) {
        return const CircularProgressIndicator();
      }
      if (state is DailyCartoonLoad) {
        return Column(
          children: [
            Text(l10n.dailyCartoonTitle),
            Container(
              key: const Key('dailyCartoonView_DailyCartoonLoad_card'),
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 5,
                      spreadRadius: 3,
                      color: Colors.black54)
                ],
              ),
              child: Text('${state.dailyCartoon.description}'),
            ),
          ],
        );
      } else {
        return const Text('Error while fetching political cartoon',
            key: Key('dailyCartoonView_dailyCartoonFailure_text'),
            style: TextStyle(color: Colors.red));
      }
    });
  }
}
