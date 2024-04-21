import 'package:core/styles/text_styles.dart';
import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';

import '../bloc/search/tv_series_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTvSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv-series';

  const SearchTvSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context
                    .read<TvSeriesSearchBloc>()
                    .add(FetchSearchTvSeries(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<TvSeriesSearchBloc, TvSeriesSearchState>(
              builder: (context, state) {
                if (state is TvSeriesSearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesSearchLoaded) {
                  final result = state.searchResult;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = state.searchResult[index];
                        return TvSeriesCard(movie);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(
                      child: const Center(child: Text('No data')),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
