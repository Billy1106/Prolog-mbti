:- consult('data.pl').

find_answers_to_question(QuestionIndex, Answers) :- 
    question(QuestionIndex, QuestionText),
    findall(AnswerText, answer(QuestionIndex, _, AnswerText, _, _), Answers).

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

test :-
    score_pair_list(L),
    update_score_in_list(e, 2, L, L1),
    show_score_pair_list(L1),
    write('---'), nl,
    update_score_in_list(i, 1, L1, L2),
    show_score_pair_list(L2).

isGreater(score_pair(X, V1), score_pair(_, V2), X) :- 
    V1 >= V2.

isGreater(score_pair(_, V1), score_pair(Y, V2), Y) :- 
    V1 < V2.

find_personality([score_pair(i, Vi), score_pair(e, Ve), score_pair(s, Vs), score_pair(n, Vn), score_pair(t, Vt), score_pair(f, Vf), score_pair(j, Vj), score_pair(p, Vp)], Personality) :- 
    isGreater(score_pair(i, Vi), score_pair(e, Ve), IE),
    isGreater(score_pair(s, Vs), score_pair(n, Vn), SN),
    isGreater(score_pair(t, Vt), score_pair(f, Vf), TF),
    isGreater(score_pair(j, Vj), score_pair(p, Vp), JP),
    mbti_personality(Personality, [IE, SN, TF, JP]).

ask :-
    score_pair_list(L),
    ask_questions(1, L).

ask_questions(8, FinalScore) :- 
    write('Done '), nl,
    show_score_pair_list(FinalScore),
    find_personality(FinalScore, Personality),
    write('Personality: '), write(Personality), nl,
    find_personality_name(Personality, PersonalityName),
    write('Personality Name: '), write(PersonalityName), nl.

ask_questions(QuestionIndex, PreviousScore) :- 
    QuestionIndex < 8, % need extra this line to stop the recursion, and make another ask_questions execute
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
    get_user_answer(QuestionIndex, ScoreList, NewScore).

get_user_answer(QuestionIndex, ScoreList, NewScore) :-
    read_line_to_string(user_input, UserAnswer),
    atom_string(AnswerAtom, UserAnswer),
    (   valid_answer(AnswerAtom)
    ->  processAnswer(QuestionIndex, AnswerAtom, ScoreList, NewScore)
    ;   write('Invalid Answer. Please enter a valid option from a to e: '), nl,
        get_user_answer(QuestionIndex, ScoreList, NewScore)
    ).


processAnswer(QuestionIndex, UserAnswer, ScoreList, NewScore) :- 
    answer(QuestionIndex, UserAnswer, _, M, V), !,
    write('M: '), write(M), write(' V: '), write(V), nl,
    update_score_in_list(M, V, ScoreList, NewScore).

processAnswer(QuestionIndex, _, ScoreList, NewScore) :- 
    write('Error processing answer. Please try again: '), nl,
    get_user_answer(QuestionIndex, ScoreList, NewScore).


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

