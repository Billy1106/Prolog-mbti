mbti_name(i, 'Introversion').
mbti_name(e, 'Extraversion').
mbti_name(s, 'Sensing').
mbti_name(n, 'Intuition').
mbti_name(t, 'Thinking').
mbti_name(f, 'Feeling').
mbti_name(j, 'Judging').
mbti_name(p, 'Perceiving').

mbti_personality(istj, [i, s, t, j]).
mbti_personality(isfj, [i, s, f, j]).
mbti_personality(infj, [i, n, f, j]).
mbti_personality(intj, [i, n, t, j]).
mbti_personality(istp, [i, s, t, p]).
mbti_personality(isfp, [i, s, f, p]).
mbti_personality(infp, [i, n, f, p]).
mbti_personality(intp, [i, n, t, p]).
mbti_personality(estp, [e, s, t, p]).
mbti_personality(esfp, [e, s, f, p]).
mbti_personality(enfp, [e, n, f, p]).
mbti_personality(entp, [e, n, t, p]).
mbti_personality(estj, [e, s, t, j]).
mbti_personality(esfj, [e, s, f, j]).
mbti_personality(enfj, [e, n, f, j]).
mbti_personality(entj, [e, n, t, j]).


personality_name(istj, 'The Inspector').
personality_name(isfj, 'The Protector').
personality_name(infj, 'The Counselor').
personality_name(intj, 'The Mastermind').
personality_name(istp, 'The Craftsman').
personality_name(isfp, 'The Composer').
personality_name(infp, 'The Healer').
personality_name(intp, 'The Architect').
personality_name(estp, 'The Dynamo').
personality_name(esfp, 'The Performer').
personality_name(enfp, 'The Champion').
personality_name(entp, 'The Visionary').
personality_name(estj, 'The Supervisor').
personality_name(esfj, 'The Provider').
personality_name(enfj, 'The Teacher').
personality_name(entj, 'The Commander').

keyword('alone', i).
keyword('energized', e).
keyword('socialize', e).
keyword('facts', s).
keyword('intuition', n).
keyword('think', t).
keyword('feel', f).
keyword('plan', j).
keyword('spontaneous', p).
keyword('critique', t).
keyword('compliment', f).
keyword('organized', j).
keyword('creative', p).
keyword('practical', s).
keyword('dreamer', n).
keyword('quiet', i).
keyword('bustling', e).
keyword('step-by-step', s).
keyword('step by step', s).
keyword('explore', n).
keyword('current', s).
keyword('explore', n).
keyword('predictable', j).
keyword('surprises', p).

question(1, 'Do you feel more energized by spending time alone or by socializing in a big group?').
question(2, 'After a long day, do you prefer to unwind alone or with others?').
question(3, 'When attending events, are you more likely to stay on the sidelines or engage actively with many people?').
question(4, 'When making decisions, do you rely more on concrete facts or your gut feelings?').
question(5, 'Do you prefer to focus on details and specifics or the big picture and future possibilities?').
question(6, 'In conversations, are you more interested in real-world happenings or abstract ideas and concepts?').
question(7, 'When faced with a decision, do you prioritize logic and objective criteria or people’s feelings and harmony?').
question(8, 'In disagreements, are you more likely to stick to your principles or seek to maintain the relationship at all costs?').
question(9, 'Do you find it easier to critique or compliment?').
question(10, 'Do you prefer to have plans and schedules or go with the flow?').

answer(1, a, 'Feel energized and look for people to talk to', e, 2).
answer(1, b, 'Enjoy talking with people you know well', e, 1).
answer(1, c, 'Feel a bit overwhelmed and stick to close friends', i, 1).
answer(1, d, 'Prefer to observe and listen rather than talking', i, 2).
answer(1, e, 'Find an excuse to leave early', i, 3).

answer(2, a, 'Enjoy spending time with friends and family', e, 1).
answer(2, b, 'Prefer to be alone or with one or two close friends', i, 1).
answer(2, c, 'Feel energized and look for people to talk to', e, 2).
answer(2, d, 'Enjoy talking with people you know well', e, 1).
answer(2, e, 'Feel a bit overwhelmed and stick to close friends', i, 1).

answer(3, a, 'Feel energized and look for people to talk to', e, 2).
answer(3, b, 'Enjoy talking with people you know well', e, 1).
answer(3, c, 'Feel a bit overwhelmed and stick to close friends', i, 1).
answer(3, d, 'Prefer to observe and listen rather than talking', i, 2).
answer(3, e, 'Find an excuse to leave early', i, 3).

answer(4, a, 'Enjoy spending time with friends and family', e, 1).
answer(4, b, 'Prefer to be alone or with one or two close friends', i, 1).
answer(4, c, 'Feel energized and look for people to talk to', e, 2).
answer(4, d, 'Enjoy talking with people you know well', e, 1).
answer(4, e, 'Feel a bit overwhelmed and stick to close friends', i, 1).


find_answers_to_question(QuestionIndex, Answers) :- 
    question(QuestionIndex, QuestionText),
    findall(AnswerText, answer(QuestionIndex, _, AnswerText, _, _), Answers).


% prolog cannot change the value 
score_pair(i,0).
score_pair(e,0).
score_pair(s,0).
score_pair(n,0).
score_pair(t,0).
score_pair(f,0).
score_pair(j,0).
score_pair(p,0).

score_pair_list([score_pair(i,0), score_pair(e,0), score_pair(s,0), score_pair(n,0), score_pair(t,0), score_pair(f,0), score_pair(j,0), score_pair(p,0)]).

get_score(M, V, L) :- 
    member(score_pair(M, V), L).

show_score_pair_list([]).
show_score_pair_list([score_pair(M, V)|Rest]) :-
    write(M), write(': '), write(V), nl,
    show_score_pair_list(Rest).

update_score_in_list(_, _, [], []).

update_score_in_list(M , V, [score_pair(M, Old)|Rest], [score_pair(M, New)|Rest]) :- 
    is(New, Old + V),
    update_score_in_list(M, V, Rest, Rest).

update_score_in_list(K , V, [score_pair(M, Old)|Rest], [score_pair(M, Old)|NewList]) :-
    dif(K, M),
    update_score_in_list(K, V, Rest, NewList).

increment_score(M, Inc, score_pair(M, Old), score_pair(M, New)) :- 
    score_pair(M, Old),
    is(New, Old + Inc).

test :-
    score_pair_list(L),
    update_score_in_list(i, 1, L, L1),
    show_score_pair_list(L1),
    write('---'), nl,
    update_score_in_list(e, 1, L1, L2),
    show_score_pair_list(L2).

ask :-
    score_pair_list(L),
    ask_questions(1, L).

ask_questions(3, FinalScore) :- 
    write('Done '), nl,
    show_score_pair_list(FinalScore).

ask_questions(QuestionIndex, PreviousScore) :- 
    QuestionIndex < 3, % need extra this line to stop the recursion, and make another ask_questions execute
    write('Current Question: '), write(QuestionIndex), nl,
    show_answers_to_question(QuestionIndex, PreviousScore, NewScore),
    is(NextQuestion, QuestionIndex + 1),
    ask_questions(NextQuestion, NewScore).

show_answers_to_question(_, [], []).
show_answers_to_question(QuestionIndex, ScoreList, NewScore) :- 
    write(QuestionIndex), nl,
    question(QuestionIndex, QuestionText),
    write(QuestionText), nl,
    findall(AnswerText, answer(QuestionIndex, _, AnswerText, _, _), AnswerTexts),
    findall(AnswerOption, answer(QuestionIndex, AnswerOption, _, _, _), AnswerOptions),
    show_answers(AnswerTexts, AnswerOptions),
    read_line_to_string(user_input, UserAnswer),
    atom_string(M, UserAnswer),
    processAnswer(QuestionIndex, M, ScoreList, NewScore).

processAnswer(QuestionIndex, UserAnswer, ScoreList, NewScore) :- 
    answer(QuestionIndex, UserAnswer, _, M, V),
    update_score_in_list(M, V, ScoreList, NewScore).

show_answers([], []).
show_answers([AnswerText|RestTexts],[AnswerOption|RestOptions]) :- 
    write(AnswerOption), write(') '),
    write(AnswerText), nl,
    show_answers(RestTexts, RestOptions).

% Personalities = ['Introversion', 'Sensing', 'Thinking', 'Judging']
%e.g find_personality_name(['Introversion', 'Sensing', 'Thinking', 'Judging'], PersonalityName).
find_personality_name([N1, N2, N3, N4], PersonalityName) :- 
    mbti_name(T1, N1), mbti_name(T2, N2), mbti_name(T3, N3), mbti_name(T4, N4),
    mbti_personality(Personality, [T1, T2, T3, T4]),
    personality_name(Personality, PersonalityName).
    
