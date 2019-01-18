+++
title="Type Driven Blogging"
date=2019-01-14
draft=false
+++

I haven't done a lot of writing in the past few years and I'm still getting into the swing of things.  I'm spending a surprising (at least to me) amount of time analyzing what goes on in my head when it comes time to write a blog post.  I'm generally a very introspective person so this is probably a healthy thing. 😄

<!-- more -->

Writing for a blog post is different than writing an email or text message or some code 💻.  It feels much closer to writing a paper for a class than anything else.  I'm not really sure if that's a good thing or not.  Maybe it's something that will pass as I blog more and "find my voice." 🤷‍♂️  I think one of the reasons that it feels different is because of the editing process.  Most emails are extemporaneous and informal.  There is often an implicit context and a thread of replies so if something is unclear it's easy to clarify in a reply.  Most emails do not need much structure.

The one thing that I write regularly that **does** require structure is code.  I think there might be some interesting parallels here.  When I start to write a function or a module I will often "stub out" large portions of it with empty functions or write in shorthand what I plan to write.  To come up with a successful solution to a problem you have to break it down into smaller and smaller pieces.  By scaffolding the solution with blank functions you figure out the shape of your solution and then you can go back and fill in the details. Once the problem is broken down into small enough pieces each piece becomes simple.

```cs
void DrawLine(startX, startY, endX, endY) {
    //todo
}
void DrawRectangle(x,y,width, height) {
    // Draw 4 lines 
    //  (x,y) -------- (x+width,y)
    //    |            |
    //  (x,y+height) -- (x+width,y+height)
}
void DrawRobot(Point position) {
    // Draw box for head
    // Draw box for body
    // Draw 2 boxes for legs
}

```

Writing a good blog post also needs structure so it makes sense to structure the post using the same techniques as I might use to structure code.  Start by building a scaffold of how the post will look when done.  Do this by writing down the main idea and then expand to a single sentance per paragraph.  One that's done you can revisit each paragraph and flesh it out.  Just as with code it makes sense to move back and forth through the project tweaking earlier paragraphs as the following paragraphs make the requirements of the preceding ones more clear.

On the other hand... sometimes a blog post is just rambling and that's ok too. 


