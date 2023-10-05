function out_struct = throw_session(in_struct, session)

out_struct = struct();

fields = fieldnames(in_struct);
gait_power_field = fields(contains(fields, 'P_gait'));
gait_chunks_field = fields(contains(fields, 'chunks_gait'));
nongait_power_field = fields(contains(fields, 'P_nongait'));
nongait_chunks_field = fields(contains(fields, 'chunks_nongait'));
f_gait_field = fields(contains(fields, 'F_gait'));
f_nongait_field = fields(contains(fields, 'F_nongait'));

out_struct.(gait_chunks_field{:}) = in_struct.(gait_chunks_field{:})(:,~contains(in_struct.(gait_chunks_field{:}),session));
out_struct.(gait_power_field{:}) = in_struct.(gait_power_field{:})(:,~contains(in_struct.(gait_chunks_field{:}),session));
out_struct.(nongait_chunks_field{:}) = in_struct.(nongait_chunks_field{:})(:,~contains(in_struct.(nongait_chunks_field{:}),session));
out_struct.(nongait_power_field{:}) = in_struct.(nongait_power_field{:})(:,~contains(in_struct.(nongait_chunks_field{:}),session));

out_struct.(f_gait_field{:}) = in_struct.(f_gait_field{:})(:,~contains(in_struct.(gait_chunks_field{:}),session));
out_struct.(f_nongait_field{:}) = in_struct.(f_nongait_field{:})(:,~contains(in_struct.(nongait_chunks_field{:}),session));

end
