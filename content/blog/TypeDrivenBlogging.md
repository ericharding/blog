+++
title="Type Driven Blogging"
date=2019-01-14
draft=false
+++

I haven't done a lot of writing in the past few years and I'm still getting into the swing of things.  I'm spending a surprising (at least to me) amount of time analyzing what goes on in my head when it comes time to write a blog post.  I'm generally a very introspective person so this is probably a healthy thing. 😄

<!-- more -->

Writing for a blog post is different than writing an email or text message or some code 💻.  It feels much closer to writing a paper for a class than anything else.  I'm not really sure if that's a good thing or not.  Maybe it's something that will pass as I blog more and "find my voice." 🤷‍♂️  I think one of the reasons that it feels differnet is because of the implicit editing process.  Most emails are unstructured and conversational.  They have an implicit context and a thread of replies so if something is unclear it's easy to clarify in a reply.  Most emails are not trying to explain a complex topic so they dont' require a lot of planning about how the document will be structured.

The one thing that I write regularly that **does** require structure is code.  I think there might be some interesting parallels here.  When I start to write a function or a module I will often "stub out" large portions of it with empty functions or write in shorthand what I plan to write.  To come up with a successful solution to a problem you have to break it down into smaller and smaller pieces.  By scaffolding the solution with blank functions you figure out the shape of your solution and then you can go back and fill in the details.

```c#
void DrawLine(float startx, float starty, float endx, float endy) {
    //todo
}
void DrawRectangle(float left, float top, float width, float height) {
    // Draw 4 lines to make the outside
    DrawLine(left, top, left + width, top);
}

```

Using 


```fsharp
let drawRect left right width height =
    // draw 4 lines
    drawLine a b c
```





