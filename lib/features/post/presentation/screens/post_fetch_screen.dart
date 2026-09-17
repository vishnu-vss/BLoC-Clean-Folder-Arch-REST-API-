import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_bloc.dart';

class PostFetchScreen extends StatefulWidget {
  const PostFetchScreen({super.key});

  @override
  State<PostFetchScreen> createState() => _PostFetchScreenState();
}

class _PostFetchScreenState extends State<PostFetchScreen> {
  @override
  void initState() {
    super.initState();

    context.read<PostBloc>().add(const FetchPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Posts',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<PostBloc>().add(const FetchPostsEvent());
            },
            icon: const Icon(Icons.refresh_rounded, color: Colors.black87),
          ),
        ],
      ),

      body: SafeArea(
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: CupertinoColors.activeBlue,
                ),
              );
            }

            if (state is PostError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        size: 50,
                        color: Colors.red,
                      ),

                      const SizedBox(height: 12),

                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          context.read<PostBloc>().add(const FetchPostsEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CupertinoColors.activeBlue,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is PostLoaded) {
              final posts = state.posts;

              if (posts.isEmpty) {
                return const Center(
                  child: Text(
                    'No posts found',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      size.width * 0.05,
                      16,
                      size.width * 0.05,
                      10,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search posts...',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: CupertinoColors.activeBlue,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(
                        size.width * 0.05,
                        10,
                        size.width * 0.05,
                        30,
                      ),
                      itemCount: posts.length,
                      separatorBuilder: (_, _) {
                        return const Divider(height: 20, color: Colors.black12);
                      },
                      itemBuilder: (context, index) {
                        final post = posts[index];

                        return ListTile(
                          contentPadding: EdgeInsets.zero,

                          title: Text(
                            post.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),

                          subtitle: Text(
                            post.body,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),

                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                          ),

                          onTap: () {
                            // Post detail screen
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            // Initial state / other state
            return const Center(
              child: Text(
                'Loading posts...',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: CupertinoColors.activeBlue,
        foregroundColor: Colors.white,
        elevation: 3,

        onPressed: () {
          // Navigate to create post screen
        },

        icon: const Icon(Icons.add_rounded),

        label: const Text(
          'Create Post',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
